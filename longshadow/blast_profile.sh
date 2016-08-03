#!/bin/sh

# The parameters
BLAST_DB=../Databases/Ensemble-Human-genes-PP.fa
QUERY_FILE=/pub9/ritesh/Simulated-Data/exonicReads-read1-PP.fa
OUTPUT_FILE=output_blast/exonicReadsOnHumanGenes-blast-PP.txt

start_time=`date +%s`

#The command
blastall -p blastn -i $QUERY_FILE -d $BLAST_DB -o $OUTPUT_FILE -m 8

end_time=`date +%s`
echo BLAST execution time was `expr $end_time - $start_time` s for `$QUERY_FILE`
