#!/bin/bash

LANE_1=$1 #../BowtieMappings_single/lane_1
LANE_2=$2 #../BowtieMappings_single/lane_2
OUTDIR=$3

FEMALE_1="$LANE_1/1-Lane_1.sorted.bam $LANE_2/1-Lane_2.sorted.bam"
FEMALE_2="$LANE_1/2-Lane_1.sorted.bam $LANE_2/2-Lane_2.sorted.bam"
FEMALE_3="$LANE_1/3-Lane_1.sorted.bam $LANE_2/3-Lane_2.sorted.bam"
FEMALE_4="$LANE_1/4-Lane_1.sorted.bam $LANE_2/4-Lane_2.sorted.bam"
FEMALE_5="$LANE_1/5-Lane_1.sorted.bam $LANE_2/5-Lane_2.sorted.bam"
FEMALE_6="$LANE_1/6-Lane_1.sorted.bam $LANE_2/6-Lane_2.sorted.bam"
FEMALE_7="$LANE_1/7-Lane_1.sorted.bam $LANE_2/7-Lane_2.sorted.bam"
FEMALE_8="$LANE_1/8-Lane_1.sorted.bam $LANE_2/8-Lane_2.sorted.bam"
FEMALE_9="$LANE_1/9-Lane_1.sorted.bam $LANE_2/9-Lane_2.sorted.bam"
FEMALE_10="$LANE_1/10-Lane_1.sorted.bam $LANE_2/10-Lane_2.sorted.bam"
FEMALE_11="$LANE_1/11-Lane_1.sorted.bam $LANE_2/11-Lane_2.sorted.bam"
FEMALE_12="$LANE_1/12-Lane_1.sorted.bam $LANE_2/12-Lane_2.sorted.bam"

samtools cat -o $OUTDIR/FEMALE_1.bam $FEMALE_1
samtools cat -o $OUTDIR/FEMALE_2.bam $FEMALE_2
samtools cat -o $OUTDIR/FEMALE_3.bam $FEMALE_3
samtools cat -o $OUTDIR/FEMALE_4.bam $FEMALE_4
samtools cat -o $OUTDIR/FEMALE_5.bam $FEMALE_5
samtools cat -o $OUTDIR/FEMALE_6.bam $FEMALE_6
samtools cat -o $OUTDIR/FEMALE_7.bam $FEMALE_7
samtools cat -o $OUTDIR/FEMALE_8.bam $FEMALE_8
samtools cat -o $OUTDIR/FEMALE_9.bam $FEMALE_9
samtools cat -o $OUTDIR/FEMALE_10.bam $FEMALE_10
samtools cat -o $OUTDIR/FEMALE_11.bam $FEMALE_11
samtools cat -o $OUTDIR/FEMALE_12.bam $FEMALE_12



MALE_1="$LANE_1/13-Lane_1.sorted.bam $LANE_2/13-Lane_2.sorted.bam"
MALE_2="$LANE_1/14-Lane_1.sorted.bam $LANE_2/14-Lane_2.sorted.bam"
MALE_3="$LANE_1/15-Lane_1.sorted.bam $LANE_2/15-Lane_2.sorted.bam"
MALE_4="$LANE_1/16-Lane_1.sorted.bam $LANE_2/16-Lane_2.sorted.bam"
MALE_5="$LANE_1/17-Lane_1.sorted.bam $LANE_2/17-Lane_2.sorted.bam"
MALE_6="$LANE_1/18-Lane_1.sorted.bam $LANE_2/18-Lane_2.sorted.bam"
MALE_7="$LANE_1/19-Lane_1.sorted.bam $LANE_2/19-Lane_2.sorted.bam"
MALE_8="$LANE_1/20-Lane_1.sorted.bam $LANE_2/20-Lane_2.sorted.bam"
MALE_9="$LANE_1/21-Lane_1.sorted.bam $LANE_2/21-Lane_2.sorted.bam"
MALE_10="$LANE_1/22-Lane_1.sorted.bam $LANE_2/22-Lane_2.sorted.bam"
MALE_11="$LANE_1/23-Lane_1.sorted.bam $LANE_2/23-Lane_2.sorted.bam"
MALE_12="$LANE_1/24-Lane_1.sorted.bam $LANE_2/24-Lane_2.sorted.bam"


samtools cat -o $OUTDIR/MALE_1.bam $MALE_1
samtools cat -o $OUTDIR/MALE_2.bam $MALE_2
samtools cat -o $OUTDIR/MALE_3.bam $MALE_3
samtools cat -o $OUTDIR/MALE_4.bam $MALE_4
samtools cat -o $OUTDIR/MALE_5.bam $MALE_5
samtools cat -o $OUTDIR/MALE_6.bam $MALE_6
samtools cat -o $OUTDIR/MALE_7.bam $MALE_7
samtools cat -o $OUTDIR/MALE_8.bam $MALE_8
samtools cat -o $OUTDIR/MALE_9.bam $MALE_9
samtools cat -o $OUTDIR/MALE_10.bam $MALE_10
samtools cat -o $OUTDIR/MALE_11.bam $MALE_11
samtools cat -o $OUTDIR/MALE_12.bam $MALE_12


