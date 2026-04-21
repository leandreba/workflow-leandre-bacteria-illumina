#!/usr/bin/env nextflow

process bracken {

    input:
    tuple val(id), path(kraken_report), path(kraken_output)
    
    script:
    
    """
    bracken -i ${kraken_report} -d $projectDir/db/kraken/ -o ${id}.output -w ${id}_bracken.report -r 150 > ${id}_bracken.log
    awk -F'\t' '{print \$6 "\t" \$1}' *.output | sort -nr | head -1 | cut -f2 | tr -d '\n'
    """

    output:
    tuple val(id), path("*.report"), path("*.output"), path("*_bracken.log"), emit : reports
    stdout emit : species_identity
    path("*.report"), emit : mqc

}