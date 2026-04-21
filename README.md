# Mon TFE v1.0.0
# Introduction
Ce workflow est destiné à l'analyse de bactéries par séquençage Illumina.
Son but premier est d'être utilisé dans des cas de santé publique, pouvoir fournir une analyse simple et rapide sur des bactèrie pathogènes et pouvoir vite prendre des mesures contre de potentiels épidémies. Le workflow permet l'identification des bactèries de ses gènes de résistances et de virulences, ainsi que son sequence type. 

## Programmes fonctionnels dans cette verion du workflow
- [x] Fastqc (0.12.1)
- [x] Fastp (1.1.0)
- [x] Kraken2 (+ Bracken ?)
- [x] Spades (4.2.0)
- [x] AMRFinder+ (4.2.7)
- [x] Virulencefinder (3.2.0)
- [x] MLST (2.32.2)
- [x] MultiQC (1.33)
- [ ] Bakta
- [ ] Panaroo
- [ ] IQ-TREE3


# Installation
## Pré-requis
Le gestionnaire de workflow Nextflow ainsi que le gestionnaire de conteneurs Apptainer sont requis.

Pour Nextflow je vous renvoi à la [procédure d'installation officielle](https://www.nextflow.io/docs/latest/install.html).

Pareillement pour [Apptainer](https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages). 

(Si vous rencontrez des problèmes lors de l'installation des pré-requis, verifiez bien que les dépendances sont bien instalées et que vous executez bien les commandes en mode `sudo`).

## Télécharger la dernière release
Pour cela :

```
wget https://github.com/leandreba/wgs_bacteria_illumina/archive/refs/tags/v1.0.0.tar.gz
tar -xvf v1.0.0.tar.gz
```

## Installer les programmes via les images Apptainer
Le script `./install.sh` permet de télécharger et installer les différents containers et databases utilisés par le workflow :

```
cd chemin_du_dossier_téléchargé
./install.sh
```

Vous pouvez églament attribuer le nombre de coeurs et de memoire vive à attribué au workflow dans le fichier `nextflow.config` :

```
nano nextflow.config
```

```
params {
    input = '.'
    threads = 8 //<============================= Valeur à changer
    memory = 16 //<============================= Valeur à changer
}
```

# Utilisation
Il faut executer le script `main.nf` avec `nextflow` et mettre un parametre `--input` correspondant au dossier avec les tous les fichiers fastq **sans sous dossiers**. Le programme détecte directement les fichiers pairs.

```
nextflow run chemin_d'instalation/main.nf --input dossier_avec_les_fastq
```

# Sorties
Nextflow crée deux dossiers `work` et `results`.

## Work
Contient tous les résultats de chaque programme.
Nextflow trie les résultats par opérations, l’organisation est assez chaotique. Le but de ce dossier n’est pas d’être parcouru.

## Results
Contient tous les résultats utiles à l’interprétation nous retrouvons des dossiers pour chaque échantillon (paire de FASTQ), puis des sous-dossiers par programme, contenant les différents rapports et logs. C'est à la racine du dossier `results` que se trouve `multiqc_report.html` qui est le **rapport principal** contenant le résumé de tous nos résultats. 