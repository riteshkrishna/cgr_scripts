#!/bin/sh

# Assembly list file can be created as the instructions given at - http://www.nature.com/nprot/journal/v7/n3/full/nprot.2012.016.html

REFGENOME=$1
REF_GFF=$2
ASSEMBLY_FILE_LIST=$3
OUTDIR=$4

$CUFFLINK/cuffmerge -p 20 -g $REF_GFF -s $REFGENOME $ASSEMBLY_FILE_LIST -o $OUTDIR

