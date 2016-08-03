#!/bin/bash

# Provide a genome file (two column tab file - name \t size) and window size. The program will produce an output BED file
genome_file=$1
win_size=$2
out_win_bed_file=$3

#Use this version of bedtools 
BEDTOOLS=/pub9/ritesh/tools/bedtools-2.17.0/bin
WIN_TOOL=windowMaker

# Use bedtools to create a windowed bed file from genome file
$BEDTOOLS/$WIN_TOOL -g $genome_file -w $win_size > $out_win_bed_file

