#!/bin/bash

INPUT_DIR=$1

for file in $INPUT_DIR/*.bam
do
	echo "processing .. $file ..."

	BAM_NAME=`basename $file .bam`
	SORTED_BAM=$BAM_NAME.sorted

	samtools sort $INPUT_DIR/$BAM_NAME.bam $INPUT_DIR/$SORTED_BAM
done

for file in $INPUT_DIR/*.sorted.bam
do
        samtools index $file $file.bai
done



