#!/bin/bash

## assumes star version 2.7.11b
## assumes STAR is available on the Path

start=`date +%s`
echo $HOSTNAME

outpath="References"
mkdir -p ${outpath}

cd ${outpath}

wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M35/GRCm39.primary_assembly.genome.fa.gz
gunzip GRCm39.primary_assembly.genome.fa.gz
FASTA="../GRCm39.primary_assembly.genome.fa"

wget wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M35/gencode.vM35.primary_assembly.annotation.gtf.gz
gunzip gencode.vM35.primary_assembly.annotation.gtf.gz
GTF="../gencode.vM35.primary_assembly.annotation.gtf"

mkdir star.overlap100.gencode.M35
cd star.overlap100.gencode.M35

call="STAR
    --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir . \
    --genomeFastaFiles ${FASTA} \
    --sjdbGTFfile ${GTF} \
    --sjdbOverhang 100"

echo $call
eval $call

end=`date +%s`
runtime=$((end-start))
echo $runtime
