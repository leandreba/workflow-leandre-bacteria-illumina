#!/usr/bin/env nextflow

process mlst {

    input:
    tuple val(id), path(spades)
    val(threads)
    
    script:
    
    """
    mlst ${spades}/contigs.fasta --full --threads ${threads} --outfile mlst.report
    echo -e "# id: "mlst" 
    # section_name: "MLST"
    # description: "Les différents sequences type"
    # format: "tsv" 
    # plot_type: "table"" > ${id}_mlst_mqc.tsv
    sed -i 's/_spades\\/contigs.fasta//' mlst.report 
    cat mlst.report >> ${id}_mlst_mqc.tsv
    """

    output:
    tuple val(id), path("*.report"), path("*_mqc.tsv"), emit : report
    path("*_mqc.tsv"), emit : mqc

}