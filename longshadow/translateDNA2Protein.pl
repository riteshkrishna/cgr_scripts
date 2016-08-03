#!/usr/local/bin/perl

# Program takes a DNA FASTA file and translate the sequences to Protein 
# using the default setup in BioPerl


use strict;
use Bio::SeqIO;
 
my $gene_file="BRAC2-genes.fasta";
my $prot_file="Protein-".$gene_file;

open PROTFILE ,">$prot_file";

my $seqio_obj = Bio::SeqIO->new(-file => $gene_file, -format => "fasta" );

while(my $seq_obj = $seqio_obj->next_seq){
	my $prot_obj = $seq_obj->translate;
	print PROTFILE ">Prot-".$seq_obj->display_id."\n".$prot_obj->seq."\n";
}

close PROTFILE;
