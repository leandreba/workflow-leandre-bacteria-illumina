#!/usr/bin/bash

cd containers

apptainer pull docker://staphb/fastqc:0.12.1

apptainer pull docker://staphb/fastp:1.1.0

apptainer pull docker://staphb/spades:4.2.0

cd ..