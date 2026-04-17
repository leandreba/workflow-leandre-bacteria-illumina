#!/usr/bin/env nextflow

process bracken {

    input:
    tuple val(id), path(kraken_report), path(kraken_output)
    
    script:
    
    """
    bracken -i ${kraken_report} -d $projectDir/db/kraken/ -o ${id}.output -w ${id}_bracken.report -r 150
    """

    output:
    tuple val(id), path("*.report"), path("*.output")

}