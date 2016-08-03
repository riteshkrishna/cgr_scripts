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
	R1=$SAMPLE/*121109_R1_trim.fastq.gz  
	R2=$SAMPLE/*121109_R2_trim.fastq.gz
	SIN=$SAMPLE/*121109_singlet.fastq.gz 
	run_topHat $R1 $R2 $SIN $BT_INDEX $OUT_DIR_1
	
	OUT_DIR_2=$OUT_DIR_BASE/out_2_`basename $SAMPLE`
	R1=$SAMPLE/*121207_R1_trim.fastq.gz  
	R2=$SAMPLE/*121207_R2_trim.fastq.gz
	SIN=$SAMPLE/*121207_singlet.fastq.gz 

	# Some folders have the other replicate missing, so do a check for file existence
	if [-e "$R1"]
	then
		run_topHat $R1  $R2 $SIN $BT_INDEX $OUT_DIR_2
	fi

}


OUT_DIR_BASE=/pub9/ritesh/Plutella/TophatMapping/female
BT_INDEX=/pub9/ritesh/Plutella/sequenceStorage/HGAP_NOV2014_polished

DATA_DIR=/pub20/int/rachel/ID719_PXylostella_AlistairDarby/rna_seq/reprocessed_data

SAMPLE_C1=$DATA_DIR/female/Sample_SQ1C_3_C7
SAMPLE_C3=$DATA_DIR/female/Sample_SQ1C_3_OV1_4
SAMPLE_C4=$DATA_DIR/female/Sample_SQ1C_3_C3
SAMPLE_C5=$DATA_DIR/female/Sample_SQ1C_3_OV2
SAMPLE_C6=$DATA_DIR/female/Sample_SQ1C_3_OV3
SAMPLE_IC=$DATA_DIR/female/Sample_SQ1C_3_OV7
SAMPLE_Test10=$DATA_DIR/female/Sample_SQ1C_3_C2
SAMPLE_Test5=$DATA_DIR/female/Sample_SQ1C_3_C5
SAMPLE_Test6=$DATA_DIR/female/Sample_SQ1C_3_OV5
SAMPLE_Test7=$DATA_DIR/female/Sample_SQ1C_3_C1_4


SAMPLE=$SAMPLE_C1
process_sample $SAMPLE

SAMPLE=$SAMPLE_C3
process_sample $SAMPLE

SAMPLE=$SAMPLE_C4
process_sample $SAMPLE

SAMPLE=$SAMPLE_C5
process_sample $SAMPLE

SAMPLE=$SAMPLE_C6
process_sample $SAMPLE

SAMPLE=$SAMPLE_IC
process_sample $SAMPLE

SAMPLE=$SAMPLE_Test10
process_sample $SAMPLE

SAMPLE=$SAMPLE_Test5
process_sample $SAMPLE

SAMPLE=$SAMPLE_Test6
process_sample $SAMPLE

SAMPLE=$SAMPLE_Test7
process_sample $SAMPLE

