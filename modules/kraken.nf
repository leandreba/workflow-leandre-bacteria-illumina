#!/usr/bin/env nextflow

process kraken {

    input:
    tuple val(id), path(clean_reads)
    val(threads)
    
    script:
    
    """
    k2 classify ${clean_reads[0]} ${clean_reads[1]} --db $projectDir/db/kraken/ --threads ${threads}  --report ${id}_kraken.report --output ${id}_kraken.output 
    """

    output:
    tuple val(id), path("*.report"), path("*.output"), emit : reports
    path("*.report"), emit : mqc

}