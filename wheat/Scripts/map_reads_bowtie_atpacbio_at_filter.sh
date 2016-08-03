#!/bin/bash

# Map At reads on AT reference. Filtering applied.

REF=../sequenceStorage/Aegilops_tauschii.GCA_000347335.1.28.dna.toplevel.fa

echo " Processing $SEQDATA_DIR"

SAMPLE=1
MEDIAN_INSERT_SIZE=180
MIN_INSERT_SIZE=100
MAX_INSERT_SIZE=250
LIBRARY=PBAT_AT_filter

BOWTIE_INDEX=../sequenceStorage/Aegilops_tauschii
OUTPUT_DIR=../BowtieMappings

PAIR_1=../Data/at_pacbio/at_pacbio_R1.fastq.gz
PAIR_2=../Data/at_pacbio/at_pacbio_R2.fastq.gz


RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

SAM_OUT=$OUTPUT_DIR/$LIBRARY.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 | samtools view -bShT $REF -F 4 -q 10 - > $SAM_OUT.bam

