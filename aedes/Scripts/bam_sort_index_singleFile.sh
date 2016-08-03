#!/bin/bash

BAM_INPUT=$1

BAM_DIR=`dirname $BAM_INPUT`
BAM_FILE=`basename $BAM_INPUT .bam`

SORTED_BAM=$BAM_FILE.sorted

samtools sort $BAM_INPUT  $BAM_DIR/$SORTED_BAM
samtools index $BAM_DIR/$SORTED_BAM.bam $BAM_DIR/$SORTED_BAM.bai

