#!/bin/bash --login

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=256G
#SBATCH --job-name=trust4_fastq
#SBATCH --time=300:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o trust4run_fastq_sra.output
#SBATCH -e trust4run_fastq_sra.error

# Set variables
dir_path="/QRISdata/Q7361/SRRIDS/fastqfilesncbi"
output_dir="/scratch/project/tcr_ml/trust4_sra"
fasta_file="/scratch/project/tcr_ml/trust4-processing/hg38_bcrtcr.fa"
reference_genome="/scratch/project/tcr_ml/trust4-processing/human_IMGT+C.fa"


srun trust4_run_fastq.sh "$output_dir" "$dir_path" "$fasta_file" "$reference_genome"
