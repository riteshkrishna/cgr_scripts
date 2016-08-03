#!/bin/bash

# This script uses a trimmed data for PxPP libraries. The data inputs are different from previous versions of this program. Insert size- 0-1000

SEQDATA_DIR=/pub20/arjen/trimmed_Wseq

echo " Processing $SEQDATA_DIR"

SAMPLE=1
MEDIAN_INSERT_SIZE=500
MIN_INSERT_SIZE=0
MAX_INSERT_SIZE=1000
LIBRARY=TRIMMEDPLUTHGAP

BOWTIE_INDEX=$HOME/Plutella/sequenceStorage/HGAP_NOV2014_polished
OUTPUT_DIR=$HOME/Plutella/BowtieMappings/HGAP_polished_run3

RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

# pxPP4 sample
PAIR_1=$SEQDATA_DIR/1-PxPP4_ATTACTCG-TATAGCCT_L001_R1_001_trimmed.fastq
PAIR_2=$SEQDATA_DIR/1-PxPP4_ATTACTCG-TATAGCCT_L001_R2_001_trimmed.fastq
SAM_OUT=$OUTPUT_DIR/$LIBRARY.pxPP4.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT &

# pxPP7 sample
PAIR_1=$SEQDATA_DIR/3-PxPP7_TCCGGAGA-TATAGCCT_L001_R1_001_trimmed.fastq
PAIR_2=$SEQDATA_DIR/3-PxPP7_TCCGGAGA-TATAGCCT_L001_R2_001_trimmed.fastq
SAM_OUT=$OUTPUT_DIR/$LIBRARY.pxPP7.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT &


# pxPP6 sample
PAIR_1=$SEQDATA_DIR/PxPP6_trimmed1.fastq
PAIR_2=$SEQDATA_DIR/PxPP6_trimmed2.fastq
SAM_OUT=$OUTPUT_DIR/$LIBRARY.pxPP6.sam

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT &


MIN_INSERT_SIZE=0 
MAX_INSERT_SIZE=1000

# pxGP9 sample
PAIR_1=$SEQDATA_DIR/PxGP9_trimmed1.fastq
PAIR_2=$SEQDATA_DIR/PxGP9_trimmed2.fastq
SAM_OUT=$OUTPUT_DIR/$LIBRARY.pxGP9.sam

#bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT &


# pxGP1B sample
PAIR_1=$SEQDATA_DIR/PxGP1B_trimmed1.fastq
PAIR_2=$SEQDATA_DIR/PxGP1B_trimmed2.fastq
SAM_OUT=$OUTPUT_DIR/$LIBRARY.pxGP1B.sam

#bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT &