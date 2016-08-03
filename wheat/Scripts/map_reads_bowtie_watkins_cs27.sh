#!/bin/bash

function runBowtie(){

	PAIR_1=$1
	PAIR_2=$2
	BOWTIE_INDEX=$3
	OUTPUT_DIR=$4
	REF=$5
	NAME=$6
	
	SAMPLE=1
	MEDIAN_INSERT_SIZE=180
	MIN_INSERT_SIZE=100
	MAX_INSERT_SIZE=250
	LIBRARY=$NAME

	RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
	PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"

	SAM_OUT=$OUTPUT_DIR/$LIBRARY.sam

	bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $PAIR_1 -2 $PAIR_2 | samtools view -bShT $REF -F 4 -q 10 - > $SAM_OUT.bam &
}

REF=../sequenceStorage/Triticum_aestivum.IWGSC1.0_popseq.27.dna_sm.toplevel.fa
BT_INDEX=../sequenceStorage/CS_27
WATKIN_OUTPUT_DIR=/pub9/ritesh/wheat_renseq/BowtieMappings/watkins_pacbio

# Call for different datasets
WATKIN_DATA_DIR=/pub9/ritesh/wheat_renseq/Data/watkins/pacbio/Watkins_collection

WAT_1_1=$WATKIN_DATA_DIR/1190103_max_grain_sa/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190103_max_grain_sa/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190103"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME


WAT_1_1=$WATKIN_DATA_DIR/1190141_max_height/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190141_max_height/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_I1190141"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME


WAT_1_1=$WATKIN_DATA_DIR/1190238_max_1000_grain_weight/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190238_max_1000_grain_weight/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190238"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME


WAT_1_1=$WATKIN_DATA_DIR/1190292_min_height/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190292_min_height/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190292"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME


WAT_1_1=$WATKIN_DATA_DIR/1190308_min_1000_grain_weight/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190308_min_1000_grain_weight/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190308"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME

WAT_1_1=$WATKIN_DATA_DIR/1190627_max_grain_length/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190627_max_grain_length/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190627"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME

WAT_1_1=$WATKIN_DATA_DIR/1190811_min_grain_length/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190811_min_grain_length/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190811"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME

WAT_1_1=$WATKIN_DATA_DIR/1190827_min_grain_sa/NBS-LRR/Output1_plus_pacbio.fastq.gz
WAT_1_2=$WATKIN_DATA_DIR/1190827_min_grain_sa/NBS-LRR/Output2_plus_pacbio.fastq.gz
NAME="wat_1190827"
runBowtie $WAT_1_1 $WAT_1_2 $BT_INDEX $WATKIN_OUTPUT_DIR $REF $NAME

