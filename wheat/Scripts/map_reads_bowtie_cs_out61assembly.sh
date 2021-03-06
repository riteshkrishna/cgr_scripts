#!/bin/bash

REF=../Analysis/assembly/out_assembly/out.61/case_gapcloser.scafSeq

echo " Processing $SEQDATA_DIR"

SAMPLE=1
MEDIAN_INSERT_SIZE=180
MIN_INSERT_SIZE=100
MAX_INSERT_SIZE=250
LIBRARY=CS_ASS61MER

BOWTIE_INDEX=../Analysis/assembly/out_assembly/out.61/case61_bt2
OUTPUT_DIR=../Analysis

PAIR_1=../Data/cs_nblrr/CS_new_Non-treated_hitting_NBS-LRR_R1.fastq
PAIR_2=../Data/cs_nblrr/CS_new_Non-treated_hitting_NBS-LRR_R2.fastq


RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

SAM_OUT=$OUTPUT_DIR/$LIBRARY.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 | samtools view -bShT $REF -F 4 -q 10 - > $SAM_OUT.bam

