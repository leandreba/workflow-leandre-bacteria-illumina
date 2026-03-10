#!/usr/bin/env nextflow
//lsite des parametres par default si pas inscris 

//définis le process à executer (equivalent à une fonction entre gros guillemets)
process fastqc {

    input:
    tuple val(id), path(reads)
    
    script:
    
    """
    fastqc --memory 2000 -t 8 '${reads[0]}' '${reads[1]}' 
    """

    output:
    tuple val(id) ,path("*_fastqc.html") , path("*_fastqc.zip") //au format tupple car sinon on doit declarer nos output 1 par 1 apres dans publish 
}



