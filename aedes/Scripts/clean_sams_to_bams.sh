#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2
REF=$3

for file in $INPUT_DIR/*.sam
do
	echo "processing .. $file ..."

	SAM_NAME=`basename $file .sam`
	SORTED_BAM=$SAM_NAME.sorted

	samtools view -bShT $REF -F 4 -q 10 $file > $OUTPUT_DIR/$SAM_NAME.bam
	samtools sort $OUTPUT_DIR/$SAM_NAME.bam $OUTPUT_DIR/$SORTED_BAM
done


