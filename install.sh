#!/usr/bin/bash

#####################################################################################
#Création du dossier containers et db, télécharmgement et extraction des images.
#####################################################################################
mkdir containers

cd containers

apptainer pull docker://staphb/fastqc:0.12.1
apptainer pull docker://staphb/fastp:1.1.0

apptainer pull docker://staphb/bracken:3.1

apptainer pull docker://staphb/spades:4.2.0

apptainer pull docker://staphb/ncbi-amrfinderplus:4.2.7-2026-03-24.1
apptainer pull docker://staphb/mlst:2.32.2
apptainer pull docker://genomicepidemiology/virulencefinder:3.2.0

apptainer pull docker://staphb/bakta:1.12.0


cd..

#####################################################################################
#Création du dossier qui stocke les databases et téléchargement/installation des DB.
#####################################################################################
mkdir db
cd db

#Kraken2
mkdir kraken
cd kraken

wget -c https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08_GB_20260226.tar.gz
tar -xvf *.tar.gz
rm *.tar.gz
mv * kraken

cd ..

#Bakta
#apptainer exec --bind .:/mnt bakta_1.12.0.sif bakta_db download --output /mnt --type light
#mv db/ bakta

cd ..
