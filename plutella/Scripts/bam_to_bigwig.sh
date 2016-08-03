#!/bin/sh

## example run - ./bam_to_bigwig.sh PLUTMALE.sorted.bam HGAP_NOV2014.polished.genome

#SORT_BAM=$1
#GENOME=$2
#BED_GRAPH=`basename $SORT_BAM`.bedGraph
#BIGWIG=`basename $SORT_BAM`.bw
#genomeCoverageBed -ibam $SORT_BAM -bg -g $GENOME > $BED_GRAPH
#bedGraphToBigWig $BED_GRAPH $GENOME $BIGWIG
#rm $BED_GRAPH

INPUT_DIR=$1
GENOME=$2
for file in $INPUT_DIR/*.sorted.bam
do
	
	SORT_BAM=$file
	BED_GRAPH=`basename $SORT_BAM`.bedGraph
	BIGWIG=`basename $SORT_BAM`.bw

	genomeCoverageBed -ibam $SORT_BAM -bg -g $GENOME > $BED_GRAPH

	bedGraphToBigWig $BED_GRAPH $GENOME $BIGWIG
	
	rm $BED_GRAPH
done

