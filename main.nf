include {fastqc as fastqc_raw} from './modules/fastqc.nf'
include {fastp} from './modules/fastp.nf'
include {fastqc as fastqc_clean} from './modules/fastqc.nf'
include {spades} from './modules/spades.nf'
include {amrfinder} from './modules/amrfinder.nf'


//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel de reads bruts
    reads = channel.fromFilePairs("${params.input}/*_R{1,2}_001*").view()
    
    //on lance la première étape de qualité
    fastqc_raw(reads, params.threads)
    fastp(reads, params.threads)

    //On crée notre channel de reads cleans à partir de notre channel fastp
    clean_reads = fastp.out.clean_reads.map {id, clean_R1, clean_R2 -> tuple(id, [clean_R1, clean_R2])}
    clean_reads.view()

    //on faitun nouveau fastqc à partir de nos reads clean
    fastqc_clean(clean_reads, params.threads)
    
    //On execute l'assemblage
    spades(clean_reads, params.threads, params.memory)
    spades.out.results.view()

    //On execute amrfinder
    amrfinder(spades.out.results, params.threads)

    publish:
    fastqc_raw_output = fastqc_raw.out
    fastp_output = fastp.out.reports
    fastqc_clean_output = fastqc_clean.out
    spades_output = spades.out.reports
    amrfinder_output = amrfinder.out

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

    spades_output {
        path {id, sapdes_log , warnings_log -> "${id}"}
    }

    amrfinder_output {
        path {id, amrfound -> "${id}"}
    }
}  