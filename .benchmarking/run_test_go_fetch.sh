#!/bin/bash
#SBATCH --partition=medium
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4

source activate skim2mito_env

START_TIME=$(date +%s)
echo "Start time: $(date)"

snakemake \
   --profile workflow/profiles/test \
   --config go_reference=go_fetch \
            user_email=o.william.white@gmail.com \
            user_api=d1a5c426985fc0e758eb07d36bf15890df08

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
echo "End time: $(date)"
echo "Total runtime: ${DURATION} seconds ($(($DURATION / 60)) minutes)"
echo Complete!
