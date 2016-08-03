#!/bin/bash

## The program takes a directory containing SAM files and first converts them to a SAM with no-header.
## The no-header SAMs are then processed using AWK to extract the unmapped reads. 
## The output file has a block-like structure, where ## followed by a SAM file path indicates beginning of a block, and the lines following that block till the occurance of a nect ##, list the accessions of unmapped reads belonging to the SAM file

SAM_DIR=$1
UNMAPPEDREAD_HEADERS=$2

for SAM in $SAM_DIR/*.sam
do
	TMP_SAM=`basename $SAM`.tmp
	grep -v '@' $SAM >> $TMP_SAM
	echo "##$SAM" >> $UNMAPPEDREAD_HEADERS
	awk 'and($2, 0x004)' $TMP_SAM | cut -f1 >> $UNMAPPEDREAD_HEADERS
	rm $TMP_SAM
done
