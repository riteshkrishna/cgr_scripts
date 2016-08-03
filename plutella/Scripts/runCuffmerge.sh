#!/bin/sh

# Assembly list file can be created as the instructions given at - http://www.nature.com/nprot/journal/v7/n3/full/nprot.2012.016.html

REFGENOME=$1
ASSEMBLY_FILE_LIST=$2
OUTDIR=$3

$CUFFLINK/cuffmerge -p 20 -s $REFGENOME $ASSEMBLY_FILE_LIST -o $OUTDIR

