#!/bin/bash -e

# This file is here for a README purpose only.
# copy of the Script for Ben's data processing - takes TopHat's merged.gtf and genome.fasta as inputs
# This script is located in ~/Software/TransDecoder-2.0.1/sample_data/runBen.sh where it can be run directly.

transcripts_gtf=$1
test_genome_fasta=$2

## generate alignment gff3 formatted output
../util/cufflinks_gtf_to_alignment_gff3.pl $transcripts_gtf > transcripts.gff3

## generate transcripts fasta file
../util/cufflinks_gtf_genome_to_cdna_fasta.pl $transcripts_gtf $test_genome_fasta > transcripts.fasta 

## Extract the long ORFs
../TransDecoder.LongOrfs -t transcripts.fasta


# just coding metrics
../TransDecoder.Predict -t transcripts.fasta 

## convert to genome coordinates
../util/cdna_alignment_orf_to_genome_orf.pl transcripts.fasta.transdecoder.gff3 transcripts.gff3 transcripts.fasta > transcripts.fasta.transdecoder.genome.gff3


## make bed files for viewing with GenomeView

# covert cufflinks gtf to bed
../util/cufflinks_gtf_to_bed.pl $transcripts_gtf > transcripts.bed

# convert the genome-based gene-gff3 file to bed
../util/gff3_file_to_bed.pl transcripts.fasta.transdecoder.genome.gff3 > transcripts.fasta.transdecoder.genome.bed

echo
echo
echo Done!  Coding region genome annotations provided as: best_candidates.eclipsed_orfs_removed.genome.gff3
echo
echo 

exit 0
