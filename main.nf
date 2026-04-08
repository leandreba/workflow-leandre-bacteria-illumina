include {fastqc} from './modules/fastqc.nf'
include {fastp} from './modules/fastp.nf'
include {spades} from './modules/spades.nf'

//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel de reads bruts
    reads = channel.fromFilePairs("${params.input}*_R{1,2}_001*").view()
    
    //on lance la première étape de qualité
    fastqc(reads)
    fastp(reads)

    //On crée notre channel de reads cleans à partir de notre channel fastp
    clean_reads = fastp.out.map {id, clean_R1, clean_R2, html, json -> tuple(id, [clean_R1, clean_R2])}
    clean_reads.view()

    //on faitun nouveau fastqc à partir de nos reads clean
    //fastqc(clean_reads)

    spades(clean_reads)

    publish:
    fastqc_output = fastqc.out
    fastp_output = fastp.out
    spades_output = spades.out
}


//dire ou ranger les outputs de nos process
output {
    fastqc_output {
        path { id, html, zip -> "${id}/fastqc"}
    }

    fastp_output {
        path {id, R1, R2, html, json -> "${id}/fastp"}
    }

    spades_output {
        path {id, spades_results -> "${id}"}
    }
}