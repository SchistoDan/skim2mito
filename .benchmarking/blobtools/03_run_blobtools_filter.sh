#!/bin/bash
#SBATCH --partition=short
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --output=job_blobtools_filter_%j.out
#SBATCH --error=job_blobtools_filter_%j.err

# activate conda environment
source activate blobtools_env

# get the memory limit allocated by SLURM (in G)
MEM=$((SLURM_MEM_PER_NODE / 1024))

echo "SLURM allocated memory: ${MEM}G"
echo "Start time: $(date)"

# set directory of blobtools create which worked 
INDIR="test_blobtools_create/mem_6G"

# set output directory for this memory test
OUTDIR="test_blobtools_filter/mem_${MEM}G"

# cp content from create to filter output directory
mkdir -p $OUTDIR
cp -r $INDIR/* $OUTDIR/

# run the test
blobtools filter \
    --table ${OUTDIR}/table.tsv \
    --table-fields gc,length,NC_039887_cov,bestsumorder_superkingdom,bestsumorder_kingdom,bestsumorder_phylum,bestsumorder_class,bestsumorder_order,bestsumorder_family,bestsumorder_species \
    $OUTDIR

EXIT_CODE=$?

echo "End time: $(date)"
echo "Exit code: $EXIT_CODE"