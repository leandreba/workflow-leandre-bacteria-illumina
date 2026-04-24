#!/usr/bin/env nextflow


process spades {

    input:
    tuple val(id), path(clean_reads)
    val(threads)
    val(memory)

    script:
    
    """
    spades.py -1 ${clean_reads[0]} -2 ${clean_reads[1]} -o ${id}_spades --careful -t ${threads} -m ${memory}
    """

    output:
    tuple val(id), path("*_spades/spades.log"), emit : report
    tuple val(id), path("*_spades"), emit : results
}