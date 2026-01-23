#!/bin/bash

# create conda environment without prompts
conda create -n mitos_env -c conda-forge -c bioconda mitos=2.1.9 entrez-direct --yes

# source activate conda environment
source activate mitos_env 

# create resources directory
mkdir -p resources/test_sequences

# download NC_039887 from NCBI using entrez direct
efetch -db nuccore -id NC_039887 -format fasta > resources/test_sequences/NC_039887.fasta

# get reference database 
wget --wait 10 --random-wait -P resources/mitos_db https://zenodo.org/records/4284483/files/refseq89m.tar.bz2
tar xf resources/mitos_db/refseq89m.tar.bz2 --directory resources/mitos_db
rm resources/mitos_db/refseq89m.tar.bz2

echo Complete!
