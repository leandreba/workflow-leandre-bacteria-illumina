# Mon TFE v0.1.0
# Introduction
Ce workflow est destiné à l'analyse de bactéries par séquençage Illumina.
Son but est de fournir une confirmation de l'identité de la bactérie, d’identifier les gènes de résistance et de virulence, ainsi que de réaliser une analyse phylogénétique de nos échantillons à partir d’un pangénome créé par l’annotation des gènes.

## Programmes fonctionnels dans cette verion du workflow
- [x] Fastqc (0.12.1)
- [x] Fastp (1.1.0)
- [ ] Kraken2 (+ Bracken ?)
- [x] Spades (4.2.0)
- [ ] AMRFinder+
- [ ] Virulencefinder
- [ ] Bakta
- [ ] Panaroo
- [ ] IQ-TREE3


# Installation
## Pré-requis
Le gestionnaire de workflow Nextflow ainsi que le gestionnaire de conteneurs Apptainer sont requis.

Pour Nextflow je vous renvoi à la [procédure d'installation officielle](https://www.nextflow.io/docs/latest/install.html).

Pareillement pour [Apptainer](https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages). 

## Télécharger les fichiers sources
Pour cela :

```
git clone git@github.com:leandreba/tfe.git
```

## Installer les programmes via les images Apptainer
Le script `./install.sh` permet de télécharger et installer les différents containers utilisés par le workflow :

```
cd chemin_du_dossier_télécharger
./install.sh
```

# Utilisation
Il faut executer le script `main.nf` avec `nextflow` et mettre un parametre `--input` correspondant au dossier avec les tous les fichiers fastq **sans sous dossiers**. Le programme détecte directememnt les fichiers pairs.

```
nextflow chemin_d'instalation/main.nf --input dossier_avec_les_fasta
```

# Sorties
Nextflow crée deux dossiers `work` et `results`.

## Work
Contient tous les résultats de chaque programme.
Nextflow trie les résultats par opérations, l’organisation est assez chaotique. Le but de ce dossier n’est pas d’être parcouru.

## Results
Contient tous les résultats utiles à l’interprétation nous retrouvons des dossiers pour chaque échantillon (paire de FASTQ), puis des sous-dossiers par programme, contenant les différents rapports et logs.