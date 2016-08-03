#!/bin/bash

REF=../Analysis/analysis_AT/assembly/out.61/case_gapcloser.scafSeq

echo " Processing $SEQDATA_DIR"

SAMPLE=1
MEDIAN_INSERT_SIZE=180
MIN_INSERT_SIZE=100
MAX_INSERT_SIZE=250
LIBRARY=AT_ASS61MER

BOWTIE_INDEX=../Analysis/analysis_AT/assembly/out.61/case61_bt2_at
OUTPUT_DIR=../Analysis/analysis_AT

PAIR_1=../Data/at_mblrr/Reads_hitting_NB-ARC_filter_R1.fastq
PAIR_2=../Data/at_mblrr/Reads_hitting_NB-ARC_filter_R2.fastq

RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

SAM_OUT=$OUTPUT_DIR/$LIBRARY.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 | samtools view -bShT $REF -F 4 -q 10 - > $SAM_OUT.bam

