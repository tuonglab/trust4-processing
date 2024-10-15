#!/bin/bash

# Check if a directory path, an output directory, a reference file, and a processed files file were provided as arguments
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 directory_path output_dir fasta_file reference_genome"
    exit 1
fi

# Set the directory path, output directory, reference file to the first, second, third respectively
dir_path="$2"
output_dir="$1"
fasta_file="$3"
reference_genome="$4"

# Create new directory
mkdir -p "$output_dir"

# # Find pairs of FASTQ files in the specified directory using the _R1.fastq.gz and _R2.fastq.gz naming convention
# for r1_file in "$dir_path"/*_R1.fastq.gz; do
#     r2_file="${r1_file%_R1.fastq.gz}_R2.fastq.gz"
#     if [ -f "$r2_file" ]; then

#         # Copy FASTQ files to $TMPDIR
#         rsync -avz "$r1_file" "$r2_file" "$TMPDIR/" --progress

#         # Process FASTQ files in $TMPDIR
#         dir=$(basename "${r1_file%_R1.fastq.gz}")
#         output_subdir="$output_dir/$dir"
#         mkdir -p "$output_subdir"
#         echo "Processing $r1_file and $r2_file"

#         # Run trust4 on the FASTQ files and save output to output_subdir
#         /scratch/user/uqachoo1/miniforge3/bin/run-trust4 -1 "$TMPDIR/$(basename "$r1_file")" -2 "$TMPDIR/$(basename "$r2_file")" -f "$fasta_file" -t 64 --od "$output_subdir"

#     fi
# done

# # Find pairs of FASTQ files in the specified directory using the _R1.fq.gz and _R2.fq.gz naming convention
# for r1_file in "$dir_path"/*_R1.fq.gz; do
#     r2_file="${r1_file%_R1.fq.gz}_R2.fq.gz"
#     if [ -f "$r2_file" ]; then

#         # Copy FASTQ files to $TMPDIR
#         rsync -avz "$r1_file" "$r2_file" "$TMPDIR/" --progress

#         # Process FASTQ files in $TMPDIR
#         dir=$(basename "${r1_file%_R1.fq.gz}")
#         output_subdir="$output_dir/$dir"
#         mkdir -p "$output_subdir"
#         echo "Processing $r1_file and $r2_file"

#         # Run trust4 on the FASTQ files and save output to output_subdir
#         /scratch/user/uqachoo1/miniforge3/bin/run-trust4 -1 "$TMPDIR/$(basename "$r1_file")" -2 "$TMPDIR/$(basename "$r2_file")" -f "$fasta_file" -t 64 --od "$output_subdir"

#         # Copy output files back to output_subdir
#         rsync -avz "$output_subdir/"* "$output_subdir/" --progress


#     fi
# done

# # Find pairs of FASTQ files in the specified directory using the _F.fq.gz and _R.fq.gz naming convention
# for r1_file in "$dir_path"/*_F.fq.gz; do
#     r2_file="${r1_file%_F.fq.gz}_R.fq.gz"
#     if [ -f "$r2_file" ]; then


#         # Copy FASTQ files to $TMPDIR
#         rsync -avz "$r1_file" "$r2_file" "$TMPDIR/" --progress

#         # Process FASTQ files in $TMPDIR
#         dir=$(basename "${r1_file%_F.fq.gz}")
#         output_subdir="$output_dir/$dir"
#         mkdir -p "$output_subdir"
#         echo "Processing $r1_file and $r2_file"

#         # Run trust4 on the FASTQ files and save output to output_subdir
#         /home/uqachoo1/mambaforge/envs/env/bin/run-trust4 -1 "$TMPDIR/$(basename "$r1_file")" -2 "$TMPDIR/$(basename "$r2_file")" -f "$fasta_file" -t 64 --od "$output_subdir"


#     fi
# done

# Loop through all subdirectories in the specified directory
for subdir in "$dir_path"/*/; do
    r1_file="${subdir}$(basename "$subdir")_1.fastq"
    r2_file="${subdir}$(basename "$subdir")_2.fastq"

    if [ -f "$r1_file" ] && [ -f "$r2_file" ]; then

        # Copy FASTQ files to $TMPDIR
        rsync -avz "$r1_file" "$r2_file" "$TMPDIR/" --progress

        # Process FASTQ files in $TMPDIR
        dir=$(basename "${r1_file%_1.fastq}")
        output_subdir="$output_dir/$dir"
        mkdir -p "$output_subdir"
        echo "Processing $r1_file and $r2_file"

        # Run trust4 on the FASTQ files and save output to output_subdir
        /scratch/user/uqachoo1/miniforge3/bin/run-trust4 -1 "$TMPDIR/$(basename "$r1_file")" -2 "$TMPDIR/$(basename "$r2_file")" -f "$fasta_file" --ref "$reference_genome" -t 64 --od "$output_subdir"

    fi
done

