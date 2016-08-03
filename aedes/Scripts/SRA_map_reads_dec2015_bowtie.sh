#!/bin/bash

SEQDATA_DIR=$HOME/Aedes_Aegypti/SRA

echo " Processing $SEQDATA_DIR"

MEDIAN_INSERT_SIZE=500
MIN_INSERT_SIZE=200
MAX_INSERT_SIZE=500
LIBRARY=VIRGINIATECH

BOWTIE_INDEX=$HOME/Aedes_Aegypti/sequenceStorage/Aedes_contigs_consensus
OUTPUT_DIR=$HOME/Aedes_Aegypti/BowtieMappings_single/SRA_data/dec2015
## -----------------------------------------------------------------------------##


for file in $SEQDATA_DIR/*_1.fastq;
do 
	file2=`basename $file | cut --delim="_" -f1`;

	SAMPLE=`basename $file | cut --delim="." -f1`;

	RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
	PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

	PAIR_1=$file
	PAIR_2=$SEQDATA_DIR/$file2\_2.fastq
	SAM_OUT=$OUTPUT_DIR/$file2.sam

	bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT 

done

