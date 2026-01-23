#!/bin/bash

# run memory limit tests from 2G to 10G in 2G increments
for i in $(seq 2 2 10); do
    sbatch --mem=${i}G 01_run_blobtools_create.sh
done

echo Complete!