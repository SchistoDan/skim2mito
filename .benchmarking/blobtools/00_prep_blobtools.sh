#!/bin/bash

# create conda environment without prompts
conda create -n blobtools_env -c conda-forge -c bioconda python=3.9 pip blast=2.17.0 entrez-direct minimap2=2.30 samtools=1.22.1 --yes && conda run -n blobtools_env pip install blobtoolkit==4.4.5

# source activate conda environment
source activate blobtools_env 

# overwrite resources directory if it exists
rm -rf resources

# create dir for resources
mkdir -p resources/test_sequences
mkdir -p resources/blastdb
mkdir -p resources/taxdump

# download NC_039887 from NCBI using entrez direct
efetch -db nuccore -id NC_039887 -format fasta > resources/test_sequences/NC_039887.fasta

# minimap2
minimap2 -ax sr resources/test_sequences/NC_039887.fasta \
   ../../.test/reads/Tacola_larymna_1.fq.gz \
   ../../.test/reads/Tacola_larymna_2.fq.gz | \
   samtools view -b -F 4 | \
   samtools sort -O BAM -o NC_039887.bam -
samtools index NC_039887.bam
samtools index -c NC_039887.bam

# get blastn database for blobtools
wget --wait 10 --random-wait -P resources/blastdb/ https://zenodo.org/records/8424777/files/refseq_mitochondrion.tar.gz
tar xvzf resources/blastdb/refseq_mitochondrion.tar.gz --directory resources/blastdb/
rm resources/blastdb/refseq_mitochondrion.tar.gz

# run blastn
blastn \
    -query resources/test_sequences/NC_039887.fasta \
    -db resources/blastdb/refseq_mitochondrion/refseq_mitochondrion \
    -out NC_039887_blastn.txt \
    -outfmt '6 qseqid staxids bitscore std' \
    -max_target_seqs 10 \
    -max_hsps 1 \
    -evalue 1e-25

# taxdump for blobtools
wget --wait 10 --random-wait -P resources/taxdump/ https://ftp.ncbi.nih.gov/pub/taxonomy/new_taxdump/new_taxdump.tar.gz
tar xvzf resources/taxdump/new_taxdump.tar.gz --directory resources/taxdump/
rm resources/taxdump/new_taxdump.tar.gz

echo Complete!