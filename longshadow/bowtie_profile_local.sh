#!/bin/sh

# The parameters
BOWTIE_DB=../Bowtie-2-Indices/Ensemble-Human-genes-PP
QUERY_FILE=/pub9/ritesh/Simulated-Data/exonicReads-read1-PP.fq
SAM_FILE_LOCAL=output_bowtie/ExonRead1-OnHuman-option-local-allreporting-PP.sam

start_time=`date +%s`


#local
bowtie2 -x $BOWTIE_DB -t -p 6 -a --very-sensitive-local   -U $QUERY_FILE -S $SAM_FILE_LOCAL

end_time=`date +%s`
echo execution time for local  was `expr $end_time - $start_time` s
