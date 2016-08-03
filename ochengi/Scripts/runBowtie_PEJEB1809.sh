#!/bin/sh

function run_bowtie() {

	INPUT_R1=$1
	INPUT_R2=$2
	BOWTIE_INDEX=$3
	OUTPUT_SAM=$4
	
	SAMPLE=1
	MEDIAN_INSERT_SIZE=180
	MIN_INSERT_SIZE=100
	MAX_INSERT_SIZE=250
	LIBRARY=OCHENGI

	RGINFO="--rg-id sample:$SAMPLE --rg SM:$SAMPLE --rg LB:$LIBRARY --rg PI:$MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
	PAIR_MAP_ARGS="--fr -I $MIN_INSERT_SIZE -X $MAX_INSERT_SIZE"

	bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $BOWTIE_INDEX -1 $INPUT_R1 -2 $INPUT_R2 -S $OUTPUT_SAM &
}

function process_sample() {
	
	DATA_DIR=$1
	
	OUT_SAM=$OUT_DIR_BASE/out_39.sam
	R1=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-039_1.sanfastq.gz
	R2=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-039_2.sanfastq.gz
	run_bowtie $R1 $R2 $BT_INDEX $OUT_SAM
	
	OUT_SAM=$OUT_DIR_BASE/out_40.sam
	R1=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-040_1.sanfastq.gz
	R2=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-040_2.sanfastq.gz
	run_bowtie $R1 $R2 $BT_INDEX $OUT_SAM 

	OUT_SAM=$OUT_DIR_BASE/out_41.sam
	R1=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-041_1.sanfastq.gz
	R2=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-041_2.sanfastq.gz
	run_bowtie $R1 $R2 $BT_INDEX $OUT_SAM
	
	
	OUT_SAM=$OUT_DIR_BASE/out_29.sam
	R1=$DATA_DIR/r_oo_120126_6_pe029_1.sanfastq.gz
	R2=$DATA_DIR/r_oo_120126_6_pe029_2.sanfastq.gz
	run_bowtie $R1 $R2 $BT_INDEX $OUT_SAM

	OUT_SAM=$OUT_DIR_BASE/out_30.sam
	R1=$DATA_DIR/r_oo_120126_6_pe030_1.sanfastq.gz
	R2=$DATA_DIR/r_oo_120126_6_pe030_2.sanfastq.gz
	run_bowtie $R1 $R2 $BT_INDEX $OUT_SAM
	
	OUT_SAM=$OUT_DIR_BASE/out_31.sam
	R1=$DATA_DIR/r_oo_120126_6_pe031_1.sanfastq.gz
	R2=$DATA_DIR/r_oo_120126_6_pe031_2.sanfastq.gz
	run_bowtie $R1 $R2 $BT_INDEX $OUT_SAM
	
}


OUT_DIR_BASE=/pub9/ritesh/Ocengi/BowtieMapping/ochengi_PRJEB1809
BT_INDEX=/pub9/ritesh/Ocengi/sequenceStorage/onchocerca_ochengi_PRJEB1809

DATA_FOLDER=/pub9/ritesh/Ocengi/RNA_Data/edingurgh

process_sample $DATA_FOLDER


