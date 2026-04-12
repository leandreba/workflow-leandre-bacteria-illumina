#!/usr/bin/env nextflow


process spades {

    input:
    tuple val(id), path(clean_reads)

    script:
    
    """
    spades.py -1 ${clean_reads[0]} -2 ${clean_reads[1]} -o spades --careful -t 8 -m 16
    """

    output:
    tuple val(id), path("spades_results/spades.log"), path("spades_results/warnings.log"), emit : reports
    tuple val(id), path("spades_results"), emit : spades_results
}