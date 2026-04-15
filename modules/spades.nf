#!/usr/bin/env nextflow


process spades {

    input:
    tuple val(id), path(clean_reads)
    val(threads)
    val(memory)

    script:
    
    """
    spades.py -1 ${clean_reads[0]} -2 ${clean_reads[1]} -o spades --careful -t ${threads} -m ${memory}
    """

    output:
    tuple val(id), path("spades/spades.log"), path("spades/warnings.log"), emit : reports
    tuple val(id), path("spades"), emit : results
}