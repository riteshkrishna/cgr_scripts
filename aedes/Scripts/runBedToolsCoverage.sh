#!/bin/bash

# Script to perform coverageBed from BEDTools for a set of BAM files

BAM_DIR=$1
BED3_FILE=$2

for file in $BAM_DIR/*.sorted.bam
do
	BAM_FILE=`basename $file .bam`
	coverageBed -abam $file -b $BED3_FILE > $BAM_DIR/$BAM_FILE.bed
done

