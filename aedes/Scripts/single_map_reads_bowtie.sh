#!/bin/bash

## ------------------------------- USER INPUT ----------------------------------##
LANE='Lane_2'
SEQDATA_DIR=/pub19/acdguest/Beth/Sex_locus_identification/Fastq_files/$LANE

echo " Processing $SEQDATA_DIR"

MEDIAN_INSERT_SIZE=500
MIN_INSERT_SIZE=200
MAX_INSERT_SIZE=500
LIBRARY=AAEGYPTI

BOWTIE_INDEX=$HOME/Aedes_Aegypti/sequenceStorage/Aedes_contigs
OUTPUT_DIR=$HOME/Aedes_Aegypti/BowtieMappings_single/contigs_lane_2
## -----------------------------------------------------------------------------##


for file in $SEQDATA_DIR/*R1.fastq.gz;
do 
	#echo $file;
	file2=`echo $file | cut --delim="." -f1`;
	SAMPLE=`basename $file | cut --delim="." -f1`;

	RGINFO="--rg-id sample:$SAMPLE:$LANE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
	PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"	

	PAIR_1=$file
	PAIR_2=$file2.R2.fastq.gz
	SAM_OUT=$OUTPUT_DIR/$SAMPLE-$LANE.sam

	bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 -S $SAM_OUT > $SAMPLE:$LANE:single.log 

	#$BT2_COMMAND
done

