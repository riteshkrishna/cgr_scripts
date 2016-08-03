#!/bin/bash

DIR=../BowtieMappings_single/SRA_data/jan2016

FEMALE="$DIR/SRR871496.sorted.bam $DIR/SRR871497.sorted.bam"

samtools cat -o $DIR/FEMALE_SRA.bam $FEMALE



MALE="$DIR/SRR871499.sorted.bam $DIR/SRR871500.sorted.bam"


samtools cat -o $DIR/MALE_SRA.bam $MALE


