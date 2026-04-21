#!/usr/bin/env nextflow

process amrfinder{

    input:
    tuple val(id), path(spades)
    val(threads)
    
    script:
    
    """
    amrfinder -n ${spades}/contigs.fasta -o ${id}_amrfound.tsv --name ${id} --threads ${threads}
    
    echo -e "# id: "${id}_amrfinder" 
    # parent_name: "AMRFinder" 
    # parent_description: "Les diffèrents AMR détécté pour chaque échantillons" 
    # parent_id: "amrfinder_section" 
    # section_name: "${id}"
    # format: "tsv" 
    # plot_type: "table"" > ${id}_amr_mqc.tsv

    awk -F'\t' '{print \$7,"\t",\$8,"\t","\t",\$12,"\t",\$13,"\t",\$15,"\t",\$16,"\t",\$17}' *_amrfound.tsv >> ${id}_amr_mqc.tsv
    """

    output:
    tuple val(id), path("*_amrfound.tsv"), emit : report
    path("*_mqc.tsv"), emit : mqc

}