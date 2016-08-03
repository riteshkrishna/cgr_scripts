#!/bin/bash

BAM_DIR=$1

for file in $BAM_DIR/*.bam
do
        BAM_FILE=`basename $file .bam`
	SORTED_BAM=$BAM_FILE.sorted

        samtools sort $file  $BAM_DIR/$SORTED_BAM
	samtools index $BAM_DIR/$SORTED_BAM.bam $BAM_DIR/$SORTED_BAM.bai
done

