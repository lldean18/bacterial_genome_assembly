#!/bin/bash
# Laura Dean
# 30/10/26


#SBATCH --job-name=bakta
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=60g
#SBATCH --time=100:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
source $HOME/.bash_profile
conda activate bakta

# set variables
ASSEMBLY=/gpfs01/home/mbzlld/data/bryant/annotate_klebsiella/CP008827.1.fasta.gz
cd /gpfs01/home/mbzlld/data/bryant/annotate_klebsiella
mkdir -p bakta

# download database
#bakta_db download --output /gpfs01/home/mbzlld/data/databases/bakta_db --type full


# annotate the genome
bakta \
--db /gpfs01/home/mbzlld/data/databases/bakta_db/db \
--output bakta \
--genus Klebsiella \
--species pneumoniae \
--strain pneumoniae KPNIH1 \
--complete \
--gram - \
--threads 32 \
$ASSEMBLY


# cleanup env
conda deactivate

