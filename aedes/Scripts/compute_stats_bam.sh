#!/bin/bash

# Print simple stats for BAM files

BAM_DIR=$1
STAT_FILE=$2

for BAM in $BAM_DIR/*.bam
do
	echo "File : $BAM" >> $STAT_FILE
	samtools flagstat $BAM >> $STAT_FILE
done
