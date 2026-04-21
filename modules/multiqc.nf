#!/usr/bin/env nextflow

process multiqc {
    
    input:
    path(test)

    script:
    
    """
    multiqc ${test}
    """

    output:
    tuple path("*.html"), path("multiqc_data")

}