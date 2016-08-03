#!/usr/bin/perl 
use strict;

if ($#ARGV != 1 ) {
	print "usage: performBLAST  query database \n e.g.  perl performBLAST.pl ../Simulated-Data/MM7-read1.fa ../Databases/Ensemble-Human-genes";
	exit;
}

my $query=$ARGV[0];
my $database=$ARGV[1];

my $output = $query."output.txt";
my $filtered_output = $query."output.csv";

my $command="blastall -p blastn -i $query -d $database -o $output -m 8";
print $command;
system($command);

open(INPUT,$output)||die"can't open $output";
open(OUTPUT,">$filtered_output")||die "Can't open $filtered_output";

print OUTPUT"sequence_queried,sequence_hit,e_value\n";
while (my $line=<INPUT>){
	my @temp=split(/\t/,$line);
	my $sequence_queried=$temp[0];
	my $sequence_hit=$temp[1];
	my $e_value=$temp[10];
	
		print OUTPUT"$sequence_queried,$sequence_hit,$e_value\n";
	
}
close(INPUT);
close(OUTPUT);

#HEADERS-
#A - query, B - hit, C - %identity, D - No of matches, E - Mismatches, F - Gaps, G - Starting position of alignment in query, H - Ending position of alignment in query, I - Starting position of alignment in hit, J - Ending position of alignment in hit, K - e-value, J - Total score
