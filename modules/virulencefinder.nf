#!/usr/bin/env nextflow

process virulencefinder {

    input:
    tuple val(id), path(spades)
    
    script:
    
    """
    python3 -m virulencefinder -ifa ${spades}/contigs.fasta -o virulencefinder -x
    
    echo -e "# id: "${id}_virulencefinder" 
    # parent_name: "VirulenceFinder" 
    # parent_description: "Les diffèrents gènes de virulence détécté pour chaque échantillon" 
    # parent_id: "virulence_section" 
    # section_name: "${id}"
    # format: "tsv" 
    # plot_type: "table"" > ${id}_virulence_mqc.tsv

    awk -F'\t' '{print \$2,"\t",\$3,"\t",\$4,"\t",\$7,"\t",\$8}' virulencefinder/*.tsv >> ${id}_virulence_mqc.tsv
    """

    output:
    tuple val(id), path("virulencefinder/*txt"), path("virulencefinder/*tsv"), emit : reports
    path("*_virulence_mqc.tsv"), emit : mqc

}