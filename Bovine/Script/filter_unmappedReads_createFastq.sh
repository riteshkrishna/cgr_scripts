#!/bin/bash

# Filter unmapped reads and produce corresponding FASTQ file

INPUT_DIR=$1
OUTPUT_DIR=$2

for BAMFILE in $INPUT_DIR/*.bam
do
	FILENAME=`basename $BAMFILE`
	bamutils tofastq -unmapped $BAMFILE > $OUTPUT_DIR/$FILENAME.upmapped.fq
done
 



