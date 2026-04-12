#!/usr/bin/env nextflow

process fastp{

    input:
    tuple val(id), path(reads)

    script:
    
    """
    fastp -i ${reads[0]} -I ${reads[1]} -o clean_R1.fastq -O clean_R2.fastq -j fastp_${id}.json -h fastp_${id}.html -w 8
    """

    output:
    tuple val(id), path("*R1*"), path("*R2*"), emit : clean_reads
    tuple val(id), path("*.html"), path("*.json"), emit : reports
}