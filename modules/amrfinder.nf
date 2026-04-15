#!/usr/bin/env nextflow

process amrfinder{

    input:
    tuple val(id), path(spades)
    val(threads)
    
    script:
    
    """
    amrfinder -n ${spades}/contigs.fasta -o amrfound --name ${id} --threads ${threads}
    """

    output:
    tuple val(id), path("amrfound")

}