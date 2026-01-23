#!/bin/bash
#SBATCH --partition=short
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --output=job_mitos_%j.out
#SBATCH --error=job_mitos_%j.err

# activate conda environment
source activate mitos_env

# get the memory limit allocated by SLURM (in G)
MEM=$((SLURM_MEM_PER_NODE / 1024))

echo "SLURM allocated memory: ${MEM}G"
echo "Start time: $(date)"

# create output directory for this memory test
OUTDIR="test_mitos/mem_${MEM}G"
mkdir -p $OUTDIR

# run the test
runmitos.py \
   --input resources/test_sequences/NC_039887.fasta \
   --code 5 \
   --outdir $OUTDIR \
   --refseqver resources/mitos_db/refseq89m/ \
   --refdir . \
   --noplots

EXIT_CODE=$?

echo "End time: $(date)"
echo "Exit code: $EXIT_CODE"
