#!/bin/bash
source deactivate
conda remove -n mito_env --all --yes
rm -rf resources/
rm -rf test_mitos/
rm -f job_mitos_*.out
rm -f job_mitos_*.err
echo Clean up complete!