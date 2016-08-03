#!/usr/bin/env perl

  use strict;
  use warnings;


  # April 19, 2013
  #
  # This script fetches the MSA for Human ortholog genes. It looks for one2one_orthologue only
  # and that too for a specied number of species. The species list is provided in the array @desired_species
  #
  # Provide the GeneID at the command line to fetch the results.
  # Usage :  ./ensembl-compara.pl ENSG00000139618


  use lib '/pub9/ritesh/Software/ensembl/modules';
  use lib '/pub9/ritesh/Software/ensembl-compara/modules';

  use Bio::EnsEMBL::Registry;

  # Get the Gene Id from command line
  my $ensemble_gene = $ARGV[0];

  # We want to get information for only these species. Ensembl recognises only this species code and no other names.
  my @desired_species=("troglodytes","leucogenys","caballus","truncatus","lupus","musculus","domestica","gallus","rerio");

  ## Load the registry automatically
  my $reg = 'Bio::EnsEMBL::Registry';

  $reg->load_registry_from_db(
  	-host=>'ensembldb.ensembl.org',
  	-user=>'anonymous', 
  );


  my $member_adaptor = Bio::EnsEMBL::Registry->get_adaptor('Multi', 'compara', 'Member');
  my $member = $member_adaptor->fetch_by_source_stable_id('ENSEMBLGENE',$ensemble_gene);

  my $mem_id = $member->stable_id();
  my $desc = $member->chr_name().":".$member->chr_start()."-".$member->chr_end();
  my $gene_seq = $member->get_Gene()->seq();

  print $mem_id."\n";
  #print "\n".$gene_seq;

  my $homology_adaptor = Bio::EnsEMBL::Registry->get_adaptor('Multi', 'compara', 'Homology');
  my $homologies = $homology_adaptor->fetch_all_by_Member($member);

  
  # Now filter OUT the "within_species_paralogs" and others, keep only one2one orthologs

  foreach my $homology (@$homologies) {

     my $homologue_genes = $homology->gene_list();
    
=begin  # Convert the information to a list of stable_ids so we can see which gene corresponds to which gene in what way	
     my @homologue_genes_id =(" ");
     foreach my $g (@$homologue_genes){
	push(@homologue_genes_id,$g->stable_id());
     } 
     shift(@homologue_genes_id);
     print join(" and ", @homologue_genes_id) , " are ", $homology->description ,"\n" ;
     
=end
=cut

     ## Species Information	
     #print "\n\n Species information \n";
     my @species=(" ");	
     foreach my $g (@$homologue_genes){
	push(@species,$g->taxon()->species());
     } 	
     shift(@species);	
     #print "@species" . "\n";
   
     if (/$species[0]/i ~~ @desired_species || /$species[1]/i ~~ @desired_species) {
		if($homology->description =~ /ortholog_one2one/){	# The actual string used in Ensembl
		
			my $simple_align = $homology->get_SimpleAlign(-cdna=>1,-APPEND_SP_SHORT_NAME=>1,-APPEND_GENOMEDB_ID=>1);
		
   			my $cds_filename = $mem_id. "-cds.fa";
			my $alignIO = Bio::AlignIO->new(
    				-file => ">>$cds_filename",
    				-format => "fasta");
			$alignIO->write_aln($simple_align);
		}
     }

   }
