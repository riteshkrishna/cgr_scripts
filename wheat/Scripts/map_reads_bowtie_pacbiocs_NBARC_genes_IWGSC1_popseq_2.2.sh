#!/bin/bash

REF=../sequenceStorage/NBARC_genes_IWGSC1_popseq_2.2_fixed.fa

echo " Processing $SEQDATA_DIR"

SAMPLE=1
MEDIAN_INSERT_SIZE=180
MIN_INSERT_SIZE=100
MAX_INSERT_SIZE=250
LIBRARY=PBCS_NBARC_P22

BOWTIE_INDEX=../sequenceStorage/NBARC_genes_IWGSC1_popseq_2.2
OUTPUT_DIR=../BowtieMappings/cs_pacbio_nbarc_p22

PAIR_1=../Data/cs_pacbio/Output1_pbio_CS.fastq.gz
PAIR_2=../Data/cs_pacbio/Output2_pbio_CS.fastq.gz


RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

SAM_OUT=$OUTPUT_DIR/$LIBRARY.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 >  $SAM_OUT

cat $SAM_OUT | awk '$1 ~ /^@/ || $2 == 65 || $2 == 129 || $2 == 67 || $2 == 131 || $2 == 113 || $2 == 177 || $2 == 81 || $2 == 161 || $2 == 163 || $2 == 83 || $2 == 97 || $2 == 145 || $2 == 99 || $2 == 147 || $2 == 137 || $2 == 73 {{print $0}}'  > $SAM_OUT._filter.sam
