#!/usr/local/bin/perl
use strict;
use Bio::EnsEMBL::Registry;
use Getopt::Long;
use Bio::SeqIO;
 
# old style (deprecated) use the Bio::EnsEMBL::Registry
#use Bio::EnsEMBL::DBSQL::DBAdaptor;
 
# initialize some defaults
my $species = 'homo_sapiens';
my $source  = 'core'; # core or vega

my $out_seq = Bio::SeqIO->new(
                              -fg => \*STDOUT,
                              -format => 'fasta',
                             );
 
# The current way for accesing ensemble is using the registry
# it matches your API with its corresponding ensembl database version
# Also takes care of the mysql port (now is in a non standard port 5306)
my $reg = 'Bio::EnsEMBL::Registry';
 

my $registry = "Bio::EnsEMBL::Registry"; 
$registry->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org:5306/');

 
my $gene_adaptor   = $reg->get_adaptor($species, $source, 'Gene' );

 
for( my $argnum = 0; $argnum <=$#ARGV-1; $argnum = $argnum+2) {
   
    my $species = $ARGV[$argnum]; 
    my $identifier = $ARGV[$argnum+1];

   #  print "\n Species is :". $species ." and the identifier is :".$identifier ;

    my $gene_adaptor   = $reg->get_adaptor($species, $source, 'Gene' );
    my $gene = $gene_adaptor->fetch_by_stable_id($identifier);
 

    my @transcripts = @{$gene->get_all_Transcripts()};

   foreach my $transcript (@transcripts){
	if($transcript->translation()){
	     # my $cds = $transcript->translateable_seq();
             # print "\n>" . $species."-CDS-".$transcript->display_id()."\n".$cds;
              
              my $pep = $transcript->translate()->seq();
              print "\n>" . $species."-Peptide-".$transcript->translation()->stable_id()."\n". $pep ;
	}
   }
 

    #print "\n>" . $species."-".$identifier."\n". $gene->seq() . "\n";
 
}
