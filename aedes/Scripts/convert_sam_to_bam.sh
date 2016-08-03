#!/bin/bash

SAM_DIR=$1

for file in $SAM_DIR/*.sam
do 
	sam_name=`basename $file .sam`
	bam_name=$sam_name.bam
	samtools view -bS $file > $SAM_DIR/$bam_name
done
