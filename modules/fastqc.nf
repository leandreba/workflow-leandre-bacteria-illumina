#!/usr/bin/env nextflow

//définis le process à executer (equivalent à une fonction entre gros guillemets)
process fastqc {

    input:
    tuple val(id), path(reads)
    val(threads)
    val(memory)
    
    script:
    
    """
    fastqc --memory '${memory}' -t ${threads} '${reads[0]}' '${reads[1]}' 
    """

    output:
    tuple val(id) ,path("*_fastqc.html") , path("*_fastqc.zip"), emit : reports //au format tupple car sinon on doit declarer nos output 1 par 1 apres dans publish 
    path("*.{html,zip}"), emit : mqc
}



