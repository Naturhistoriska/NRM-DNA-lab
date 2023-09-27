#! /bin/sh
#!/bin/bash -l

# Slurm script example.
# Test by using
#     sbatch --test-only simple-slurm-script.sh
# Start by using
#     sbatch simple-slurm-script.sh
# Stop by using
#     scancel 1234
#     scancel -i -u $USER
#     scancel --state=pending -u $USER
# Monitor by using
#    jobinfo -u $USER
#    squeue
#

#SBATCH -J My_jobname
#SBATCH -A snic2022-22-1156
#SBATCH -t 00:15:00
#SBATCH -p core
#SBATCH -n 1
 
module load bioinfo-tools
module load bwa/0.7.17

cd /proj/nrmdnalab_storage/nobackup/my_bwa_run

bwa index Araport11_cdna_20220914_representative_gene_model

