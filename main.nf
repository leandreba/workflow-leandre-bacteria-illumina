include {fastqc} from './modules/fastqc.nf'

//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel
    //fastqc_inputs = channel.fromPath(params.input).map {f -> tuple(f.baseName, f)}
    fastqc_inputs = channel.fromFilePairs("${params.input}*_R{1,2}_001*")
    fastqc(fastqc_inputs)

    publish:
    fastqc_output = fastqc.out
}


//dire ou ranger les outputs de nos process
output {
    fastqc_output {
        path { id -> "fastqc/${id}"}
    }

}