#!/bin/bash
source deactivate
conda remove -n blobtools_env --all --yes
rm -rf resources/
rm -rf test_blobtools_create
rm -rf test_blobtools_filter
rm NC_039887.bam*
rm NC_039887_blastn.txt
rm -f job_blobtools_*.out
rm -f job_blobtools_*.err
echo Clean up complete!