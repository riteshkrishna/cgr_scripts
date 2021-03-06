#!/bin/bash

SEQDATA_DIR=/pub20/int/rachel/ID719_PXylostella_AlistairDarby/male_genomic_data/reprocessed_data

echo " Processing $SEQDATA_DIR"

SAMPLE=1
MEDIAN_INSERT_SIZE=500
MIN_INSERT_SIZE=200
MAX_INSERT_SIZE=500
LIBRARY=PLUTMALE

BOWTIE_INDEX=$HOME/Plutella/sequenceStorage/polished_assembly
OUTPUT_DIR=$HOME/Plutella/BowtieMappings/polished_assembly

PAIR_1=$SEQDATA_DIR/px16_CTTGTA_L002_R1_trim_001.fastq.gz
PAIR_2=$SEQDATA_DIR/px16_CTTGTA_L002_R2_trim_001.fastq.gz


RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

SAM_OUT=$OUTPUT_DIR/$LIBRARY.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT

