#!/bin/bash

INPUT_DIR=$1

BOWTIE_INDEX=../sequenceStorage/Bos_taurus
OUTPUT_DIR=../BowtieMappings/onCow/mappedReads


#for INPUT in $INPUT_DIR/*.gz
for INPUT in $INPUT_DIR/*.fq
do
	READS=`basename $INPUT .fq`
	bowtie2 -p 30 -x $BOWTIE_INDEX -U $INPUT | samtools view -bS - > $OUTPUT_DIR/$READS.bam
done
 


