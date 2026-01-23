#!/bin/bash

# run memory limit tests from 2G to 10G in 2G increments
for i in $(seq 2 2 10); do
    sbatch --mem=${i}G 03_run_blobtools_filter.sh
done

echo Complete!