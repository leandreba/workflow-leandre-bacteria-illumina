include {fastqc as fastqc_raw} from './modules/fastqc.nf'
include {fastp} from './modules/fastp.nf'
include {fastqc as fastqc_clean} from './modules/fastqc.nf'

include {kraken} from './modules/kraken.nf'
include {bracken} from './modules/bracken.nf'

include {spades} from './modules/spades.nf'

include {amrfinder} from './modules/amrfinder.nf'
include {mlst} from './modules/mlst.nf'
include {virulencefinder} from './modules/virulencefinder.nf'

include {multiqc} from './modules/multiqc.nf'

//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel de reads bruts
    reads = channel.fromFilePairs("${params.input}/*_R{1,2}_001*")
    
    //on lance la première étape de qualité
    fastqc_raw(reads, params.threads)
    fastp(reads, params.threads)

    //On crée notre channel de reads cleans à partir de notre channel fastp
    clean_reads = fastp.out.clean_reads.map {id, clean_R1, clean_R2 -> tuple(id, [clean_R1, clean_R2])}

    //on faitun nouveau fastqc à partir de nos reads clean
    fastqc_clean(clean_reads, params.threads)
    
    //On lance Kraken2 pour l'idenfication des reads
    kraken(clean_reads, params.threads)
    bracken(kraken.out.reports)

    //On execute l'assemblage
    spades(clean_reads, params.threads, params.memory)

    //On execute amrfinder
    amrfinder(spades.out.results, params.threads)
    mlst(spades.out.results, params.threads)
    virulencefinder(spades.out.results)

    //on crée le channel avec tous nos résultats pour multiqc
    ch_multiqc = Channel.empty()
    ch_multiqc = ch_multiqc.mix(fastqc_raw.out.mqc)
    ch_multiqc = ch_multiqc.mix(fastp.out.mqc)
    ch_multiqc = ch_multiqc.mix(fastqc_clean.out.mqc)
    ch_multiqc = ch_multiqc.mix(kraken.out.mqc)
    ch_multiqc = ch_multiqc.mix(bracken.out.mqc)
    ch_multiqc = ch_multiqc.mix(amrfinder.out.mqc)
    ch_multiqc = ch_multiqc.mix(mlst.out.mqc)
    ch_multiqc = ch_multiqc.mix(virulencefinder.out.mqc)

    multiqc(ch_multiqc.collect())

    publish:
    fastqc_raw_output = fastqc_raw.out.reports
    fastp_output = fastp.out.reports
    fastqc_clean_output = fastqc_clean.out.reports

    kraken_output = kraken.out.reports
    bracken_output = bracken.out.reports

    spades_output = spades.out.reports
    
    amrfinder_output = amrfinder.out.report
    mlst_output = mlst.out.report
    virulencefinder_output = virulencefinder.out.reports

    multiqc_output = multiqc.out
}

//dire ou ranger les outputs de nos process
output {
    fastqc_raw_output {
        path { id, html, zip -> "${id}/fastqc_raw"}
    }

    fastp_output {
        path {id, html, json -> "${id}/fastp"}
    }

    fastqc_clean_output {
            path { id, html, zip -> "${id}/fastqc_clean"}
        }

    kraken_output {
        path {id, kraken_report, kraken_output -> "${id}/kraken"}
    }

    bracken_output {
        path {id, bracken_report, bracken_output, log -> "${id}/bracken"}
    }

    spades_output {
        path {id, sapdes_log , warnings_log -> "${id}"}
    }

    amrfinder_output {
        path {id, amrfound-> "${id}"}
    }

    mlst_output {
        path {id, mlst_report -> "${id}"}
    }

    virulencefinder_output {
        path {id, virulencefinder_txt, virulencefinder_tsv -> "${id}"}
    }

    multiqc_output {
        path {html, data -> ""}
    }
}  