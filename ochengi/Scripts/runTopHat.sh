#!/bin/sh

function run_topHat() {

	INPUT_R1=$1
	INPUT_R2=$2
	BOWTIE_INDEX=$3
	OUTPUT_DIR=$4
	GFF=$5

	#tophat2 -o $OUTPUT_DIR -p 16 -r 180 --mate-std-dev=50 --library-type=fr-unstranded -G $GFF $BOWTIE_INDEX $INPUT_R1 $INPUT_R2

	# Ignoring inset information
	tophat2 -o $OUTPUT_DIR -p 16 --library-type=fr-unstranded -G $GFF $BOWTIE_INDEX $INPUT_R1 $INPUT_R2

}

function process_sample() {
	
	DATA_DIR=$1
	GFF=$2
	
	OUT_DIR_1=$OUT_DIR_BASE/out_39
	R1=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-039_1.sanfastq.gz
	R2=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-039_2.sanfastq.gz
	run_topHat $R1 $R2 $BT_INDEX $OUT_DIR_1 $GFF
	
	OUT_DIR_1=$OUT_DIR_BASE/out_40
	R1=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-040_1.sanfastq.gz
	R2=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-040_2.sanfastq.gz
	run_topHat $R1 $R2 $BT_INDEX $OUT_DIR_1 $GFF

	OUT_DIR_1=$OUT_DIR_BASE/out_41
	R1=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-041_1.sanfastq.gz
	R2=$DATA_DIR/130108_0252_C1CT8ACXX_4_SA-PE-041_2.sanfastq.gz
	run_topHat $R1 $R2 $BT_INDEX $OUT_DIR_1 $GFF
	
	
	OUT_DIR_1=$OUT_DIR_BASE/out_29
	R1=$DATA_DIR/r_oo_120126_6_pe029_1.sanfastq.gz
	R2=$DATA_DIR/r_oo_120126_6_pe029_2.sanfastq.gz
	run_topHat $R1 $R2 $BT_INDEX $OUT_DIR_1 $GFF

	OUT_DIR_1=$OUT_DIR_BASE/out_30
	R1=$DATA_DIR/r_oo_120126_6_pe030_1.sanfastq.gz
	R2=$DATA_DIR/r_oo_120126_6_pe030_2.sanfastq.gz
	run_topHat $R1 $R2 $BT_INDEX $OUT_DIR_1 $GFF
	
	OUT_DIR_1=$OUT_DIR_BASE/out_31
	R1=$DATA_DIR/r_oo_120126_6_pe031_1.sanfastq.gz
	R2=$DATA_DIR/r_oo_120126_6_pe031_2.sanfastq.gz
	run_topHat $R1 $R2 $BT_INDEX $OUT_DIR_1 $GFF
	
}


OUT_DIR_BASE=/pub9/ritesh/Ocengi/TophatMapping/edinburgh_WBPS2
BT_INDEX=/pub9/ritesh/Ocengi/sequenceStorage/onchocerca_volvulus_WBPS2

DATA_FOLDER=/pub9/ritesh/Ocengi/RNA_Data/edingurgh
GFF_FILE=/pub9/ritesh/Ocengi/sequenceStorage/onchocerca_volvulus.PRJEB513.WBPS2.annotations.gff3

process_sample $DATA_FOLDER $GFF_FILE


