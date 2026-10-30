#!/bin/bash
# Laura Dean
# 30/10/26


#SBATCH --job-name=bakta
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20g
#SBATCH --time=48:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
source $HOME/.bash_profile
conda activate bakta


# download database
bakta_db download --output /gpfs01/home/mbzlld/data/databases/bakta_db --type full


# cleanup env
conda deactivate

