#!/bin/sh

function run_topHat() {

	INPUT_R1=$1
	INPUT_R2=$2
	INPUT_SIN=$3
	BOWTIE_INDEX=$4
	OUTPUT_DIR=$5

	# Parameters based on Rachel's original configurations

	tophat2 -o $OUTPUT_DIR -p 16 -g 1 -r 300 --mate-std-dev=50 --library-type=fr-secondstrand $BOWTIE_INDEX $INPUT_R1 $INPUT_R2,$INPUT_SIN

}

function process_sample() {
	
	SAMPLE=$1
	
	OUT_DIR_1=$OUT_DIR_BASE/out_1_`basename $SAMPLE`
	R1=$SAMPLE/*120417_R1_trim.fastq.gz  
	R2=$SAMPLE/*120417_R2_trim.fastq.gz
	SIN=$SAMPLE/*120417_singlet.fastq.gz 
	run_topHat $R1 $R2 $SIN $BT_INDEX $OUT_DIR_1
	
	OUT_DIR_2=$OUT_DIR_BASE/out_2_`basename $SAMPLE`
	R1=$SAMPLE/*120524_R1_trim.fastq.gz  
	R2=$SAMPLE/*120524_R2_trim.fastq.gz
	SIN=$SAMPLE/*120524_singlet.fastq.gz 
	run_topHat $R1  $R2 $SIN $BT_INDEX $OUT_DIR_2
	

	#run_topHat `$SAMPLE/*120417_R1_trim.fastq.gz`  `$SAMPLE/*120417_R2_trim.fastq.gz`,`$SAMPLE/*120417_singlet.fastq.gz` $BT_INDEX $OUT_DIR_1
	#run_topHat `$SAMPLE/*120524_R1_trim.fastq.gz`  `$SAMPLE/*120524_R2_trim.fastq.gz`,`$SAMPLE/*120524_singlet.fastq.gz` $BT_INDEX $OUT_DIR_2
}


OUT_DIR_BASE=/pub9/ritesh/Plutella/TophatMapping/male
BT_INDEX=/pub9/ritesh/Plutella/sequenceStorage/HGAP_NOV2014_polished

DATA_DIR=/pub20/int/rachel/ID719_PXylostella_AlistairDarby/rna_seq/reprocessed_data

MALE_SAMPLE_C1=$DATA_DIR/male/Sample_C1_ID8
MALE_SAMPLE_C3=$DATA_DIR/male/Sample_C3_ID10
MALE_SAMPLE_C4=$DATA_DIR/male/Sample_C4_ID11
MALE_SAMPLE_C5=$DATA_DIR/male/Sample_C5_ID12
MALE_SAMPLE_C6=$DATA_DIR/male/Sample_C6_ID13
MALE_SAMPLE_IC=$DATA_DIR/male/Sample_IC-J_ID3
MALE_SAMPLE_Test10=$DATA_DIR/male/Sample_Testesx10_ID4
MALE_SAMPLE_Test5=$DATA_DIR/male/Sample_Testesx5_ID5
MALE_SAMPLE_Test6=$DATA_DIR/male/Sample_Testesx6_ID6

SAMPLE=$MALE_SAMPLE_C1
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_C3
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_C4
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_C5
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_C6
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_IC
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_Test10
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_Test5
process_sample $SAMPLE

SAMPLE=$MALE_SAMPLE_Test6
process_sample $SAMPLE

