#!/bin/bash

## assumes star version 2.7.11b
## assumes STAR is available on the Path

start=`date +%s`
echo $HOSTNAME

outpath='02-STAR_alignment'
[[ -d ${outpath} ]] || mkdir ${outpath}

REF="References/star.overlap100.gencode.M29"

for sample in `cat samples.txt`
do
  [[ -d ${outpath}/${sample} ]] || mkdir ${outpath}/${sample}
  echo "SAMPLE: ${sample}"

  call="STAR
       --runThreadN 8 \
       --genomeDir $REF \
       --outSAMtype BAM SortedByCoordinate \
       --readFilesCommand zcat \
       --readFilesIn 01-HTS_Preproc/${sample}/${sample}_SE.fastq.gz \
       --quantMode GeneCounts \
       --outFileNamePrefix ${outpath}/${sample}/${sample}_ \
       > ${outpath}/${sample}/${sample}-STAR.stdout 2> ${outpath}/${sample}/${sample}-STAR.stderr"

  echo $call
  eval $call
done

end=`date +%s`
runtime=$((end-start))
echo $runtime
