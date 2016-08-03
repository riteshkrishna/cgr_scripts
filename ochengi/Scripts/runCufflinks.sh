#!/bin/sh

BASE_DIR=$1

DIRS=`ls -l $BASE_DIR | egrep '^d' | awk '{print $8}'`

echo $DIRS

for DIR in $DIRS
do
	$CUFFLINK/cufflinks -p 20 -o $BASE_DIR/$DIR $BASE_DIR/$DIR/accepted_hits.bam
done
