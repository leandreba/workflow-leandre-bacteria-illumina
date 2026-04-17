#!/usr/bin/env nextflow

process mlst {

    input:
    tuple val(id), path(spades)
    val(scheme)
    val(threads)
    
    script:
    
    """
    mlst ${spades}/contigs.fasta --full --threads ${threads} --outfile mlst.report 2> mlst.log 
    """

    output:
    tuple val(id), path("*.report"), path("*.log")

}