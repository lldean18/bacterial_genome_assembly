#!/bin/bash
# Laura Dean
# 22/10/26

# script to demultiplex a barcoded nanopore run

#SBATCH --job-name=demux
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
source $HOME/.bash_profile
conda activate samtools1.24
mkdir -p /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls/demultiplexed
cd /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls/demultiplexed

# demultiplex basecalled bam file
dorado demux \
    --kit-name SQK-RBK114-24 \
    --output-dir /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls/demultiplexed \
    --emit-summary \
    /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls/SUP_basecalls.bam

# convert output bams to fastq.gz format
# -O output quality tags if they exist
# -t output RG, BC and QT tags to the FASTQ header line
# then pipe to gzip to compress
for bam in /gpfs01/home/mbzlld/data/bryant/Maria_1/basecalls/demultiplexed/*.bam
do
samtools bam2fq \
    -O \
    -t \
    --threads 16 \
    $bam | gzip > ${bam%.*}.fastq.gz
done

# cleanup env
conda deactivate

