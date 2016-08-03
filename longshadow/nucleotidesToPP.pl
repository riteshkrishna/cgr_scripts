# Uses Kevin's script to do the RY space conversion
#!/usr/bin/perl -w
use strict;
use warnings;

use Getopt::Std;
use File::Basename;

my %options;
getopts("i:", \%options);
my $infile = $options{i} or &usage;
sub usage {die "Usage: " . basename($0) . " [-i multi-sequence DNA fasta infile]\n";} 

open (IN, $infile) or die "ERROR: Could not open $infile.\n";
while (<IN>) {

	if (/^>/) {
		print;
		}
	elsif (/^[ACGTN]+$/i) {
		my $line = uc($_);
		$line =~ s/[AG]/A/g; # R
		$line =~ s/[CT]/T/g; # Y
		print $line;
		}
	else {
		print;
		}
	
	}
close (IN) or die "ERROR: could not close $infile.\n";
