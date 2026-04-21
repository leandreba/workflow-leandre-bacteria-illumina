#!/usr/bin/env nextflow

process fastp{

    input:
    tuple val(id), path(reads)
    val(threads)

    script:
    
    """
    fastp -i ${reads[0]} -I ${reads[1]} -o ${id}_clean_R1.fastq -O ${id}_clean_R2.fastq -j fastp_${id}.json -h fastp_${id}.html -w ${threads}
    """

    output:
    tuple val(id), path("*R1*"), path("*R2*"), emit : clean_reads
    tuple val(id), path("*.html"), path("*.json"), emit : reports
    path("*.{html,json}"), emit : mqc
}