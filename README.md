# Mon TFE v1.1.0

# Introduction
Ce workflow est destiné à l'analyse de bactéries par séquençage Illumina.  
Son but premier est d'être utilisé dans des cas de santé publique, afin de pouvoir fournir une analyse simple et rapide sur des bactéries pathogènes et permettre de prendre rapidement des mesures contre de potentielles épidémies.  
Le workflow permet l'identification des bactéries, de leurs gènes de résistance/virulence, ainsi que de leur sequence type. 

## Programmes fonctionnels dans cette version du workflow
- [x] Fastqc (0.12.1)
- [x] Fastp (1.1.0)
- [x] Kraken2 (2.17.1)
- [x] Bracken (3.1)
- [x] Spades (4.2.0)
- [x] AMRFinder+ (4.2.7)
- [x] Virulencefinder (3.2.0)
- [x] MLST (2.32.2)
- [x] MultiQC (1.33)

# Installation

## Pré-requis
Le gestionnaire de workflow Nextflow ainsi que le gestionnaire de conteneurs Apptainer sont requis.

Pour Nextflow, je vous renvoie à la [procédure d'installation officielle](https://www.nextflow.io/docs/latest/install.html).

Pareillement pour [Apptainer](https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages). 

(Si vous rencontrez des problèmes lors de l'installation des prérequis, vérifiez bien que les dépendances sont installées et que vous exécutez les commandes en mode `sudo`).

## Télécharger la dernière release
Pour cela :

```
sudo wget https://github.com/leandreba/wgs_bacteria_illumina/archive/refs/tags/v1.1.0.tar.gz
sudo tar -xvf v1.1.0.tar.gz
```

## Installer les programmes via les images Apptainer
Le script `./install.sh` permet de télécharger et d’installer les différents conteneurs/databases utilisés par le workflow.  
Lors de l’exécution, il faut également choisir le profil qui conviendra le mieux à votre ordinateur (actuellement un seul profil disponible, **high** : pour ordinateur avec 32 coeurs CPU et 64 GB de RAM).

```
cd chemin_du_dossier_téléchargé
sudo ./install.sh high
```

# Utilisation
Il faut appeler le programme `workflow-leandre-bacteria-illumina` directement dans le dossier contenant tous les fichiers fastq **sans sous-dossiers**.  
Le programme détecte automatiquement les fichiers pairs.

```
workflow-leandre-bacteria-illumina
```

## Paramètres optionnels

`--input` : Permet de spécifier le dossier contenant les FASTQ [Default : `.` (dossier actuel)].

Il est également possible d’ajouter tous les paramètres Nextflow. Je vous renvoie à la [documentation officielle](https://docs.seqera.io/nextflow/cli#pipeline-execution) pour plus d'informations.

Un paramètre très utile est `-resume` : si une interruption se produit lors de l’exécution du workflow, il permet de reprendre à l’endroit où il s’est arrêté sans tout recommencer (pour cela il faut re-exécuter depuis le même dossier).

### Exemple de commande complète :
```
workflow-leandre-bacteria-illumina --input /data/mes_fastq -resume
```

# Sorties
Nextflow crée deux dossiers `work` et `results`.

## Work
Contient tous les résultats de chaque programme.
Nextflow trie les résultats par opérations, l’organisation est assez chaotique. Le but de ce dossier n’est pas d’être parcouru.

## Results
Contient tous les résultats utiles à l’interprétation nous retrouvons des dossiers pour chaque échantillon (paire de FASTQ), puis des sous-dossiers par programme, contenant les différents rapports et logs. C'est à la racine du dossier `results` que se trouve `multiqc_report.html` qui est le **rapport principal** contenant le résumé de tous nos résultats. 