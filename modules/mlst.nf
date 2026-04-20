#!/usr/bin/env nextflow

process mlst {

    input:
    tuple val(id), path(spades)
    val(threads)
    
    script:
    
    """
    mlst ${spades}/contigs.fasta --full --threads ${threads} --outfile mlst.report
    """

    output:
    tuple val(id), path("*.report")

}