#!/bin/bash

INPUT_DIR=$1
OUTPUT_FILE=$2
GFF_REF=$3

for file in $INPUT_DIR/*.bam
do
	BAM_FILE=`basename $file .fastq.bam.upmapped.bam`
	echo "BEGIN $BAM_FILE" >> $OUTPUT_FILE
	htseq-count --type transcript -i transcript_id -f bam $file $GFF_REF >> $OUTPUT_FILE
	echo 'END' >> $OUTPUT_FILE
done



