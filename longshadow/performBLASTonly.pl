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

