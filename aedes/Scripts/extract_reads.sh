#!/bin/bash

## Specify a list of reads and extract all matching data from a list of .gz fasta files

SEQDATA_DIR=/pub19/acdguest/Beth/Sex_locus_identification/Fastq_files/Lane_2/*.fastq.gz # Location of reads
FILE_LISTOFREADS=readlistToExtract.txt		# File that conatins a list of interesting reads
OUTPUT_DIR=extractedReads			# location where the extracted reads will be stored

for file in $SEQDATA_DIR
do
	pre=`echo $file | cut --delim="." -f1`; 
	orientation=`echo $file | cut --delim="." -f2`; 
 	zgrep -f $FILE_LISTOFREADS -A 3 $file > $OUTPUT_DIR/$pre.lane2.$orientation.fastq;

done
