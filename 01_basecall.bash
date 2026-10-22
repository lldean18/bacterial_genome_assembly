#!/bin/bash
# Laura Dean
# 22/10/26

# script to SUP basecall ONT pod5 files

#SBATCH --partition=ampereq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:A100-full:1
#SBATCH --mem=256g
#SBATCH --time=160:00:00
#SBATCH --job-name=basecalling
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
module load cuda-12.2.2
mkdir -p /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls
cd /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls


# SUP basecall the reads
dorado basecaller \
	sup@latest \
        --modified-bases 6mA \
	--recursive \
	--kit-name SQK-RBK114-24 \
	--models-directory /gpfs01/home/mbzlld/data/dorado_models/dorado_models \
       	/gpfs01/home/mbzlld/data/bryant/Maria_1/no_sample_id/20260910_1040_MN49575_FBG32073_6f260b95/pod5 > SUP.bam


# unload module
module unload cuda-12.2.2


