#!/bin/bash
#SBATCH --partition=short
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --output=job_blobtools_create_%j.out
#SBATCH --error=job_blobtools_create_%j.err

# activate conda environment
source activate blobtools_env

# get the memory limit allocated by SLURM (in G)
MEM=$((SLURM_MEM_PER_NODE / 1024))

echo "SLURM allocated memory: ${MEM}G"
echo "Start time: $(date)"

# create output directory for this memory test
OUTDIR="test_blobtools_create/mem_${MEM}G"
mkdir -p $OUTDIR

# run the test
blobtools create \
    --fasta resources/test_sequences/NC_039887.fasta \
    --hits NC_039887_blastn.txt \
    --taxrule bestsumorder \
    --taxdump resources/taxdump \
    --cov NC_039887.bam \
    $OUTDIR

EXIT_CODE=$?

echo "End time: $(date)"
echo "Exit code: $EXIT_CODE"
