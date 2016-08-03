#!/usr/local/bin/perl
#use strict;
use Bio::AlignIO;
use Bio::SimpleAlign;



$str = Bio::AlignIO->new(-file => 'BRAC1-genes-Protein-Clustal.aln');

$aln = $str->next_aln();

# Describe
  print "\n Length: ".$aln->length;
  print "\n Residue: ". $aln->num_residues;
  print "\n Flush?: ". $aln->is_flush;
  print "\n No. of Seq: ".$aln->num_sequences;
  print "\n Score: ".$aln->score;
#  print "\n Prcent Idt: ".$aln->percentage_identity;
#  print "\n Cons string: ".$aln->consensus_string(50);

$pos = $aln->column_from_residue_number('Human-Peptide-ENSP00000369497', 3); 

# Extract sequences and check values for the alignment column $pos
foreach $seq ($aln->each_seq) {
      $res = $seq->subseq($pos, $pos);
      $count{$res}++;
}
foreach $res (keys %count) {
      printf "Res: %s  Count: %2d\n", $res, $count{$res};
}

#$consensus = $aln->average_percentage_identity;
#print "\n Consensus :".$consensus;

