#!/bin/bash

# Map reads on the given reference. Don't filer any result

echo "Reading config..." >&2

CONF_FILE=$1
source $CONF_FILE

echo "Config : Bowtie Index - $map_BOWTIE_INDEX" >&2
echo "Config : Map insert sizes - $map_MIN_INSERT_SIZE, $map_MEDIAN_INSERT_SIZE, $map_MAX_INSERT_SIZE" >&2
echo "Config : Data files - $map_PAIR_1, $map_PAIR_2" >&2
echo "Config : Output dir - $map_OUTPUT_DIR" >&2

RGINFO="--rg-id sample:$map_SAMPLE --rg SM:$map_SAMPLE --rg LB:$map_LIBRARY --rg PI:$map_MEDIAN_INSERT_SIZE --rg PL:ILLUMINA"
PAIR_MAP_ARGS="--fr -I $map_MIN_INSERT_SIZE -X $map_MAX_INSERT_SIZE"	

SAM_OUT=$map_OUTPUT_DIR/$map_LIBRARY.sam

echo "Starts mapping..." >&2

bowtie2 -p 20 $PAIR_MAP_ARGS $RGINFO -x $map_BOWTIE_INDEX -1 $map_PAIR_1 -2 $map_PAIR_2 | samtools view -bSh  - > $SAM_OUT.bam

echo "Finished" >&2
echo "Output BAM : $SAM_OUT" >&2

