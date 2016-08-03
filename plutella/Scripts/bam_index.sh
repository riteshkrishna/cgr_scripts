#!/bin/bash

BAM_DIR=$1

for file in $BAM_DIR/*.sorted.bam
do

	samtools index $file $file.bai
done

