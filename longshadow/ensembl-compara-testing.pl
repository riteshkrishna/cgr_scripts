# Testing the COMPARA API

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::Compara::Member;

my $registry = "Bio::EnsEMBL::Registry"; 
$registry->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org:5306/');


my $geneName = 'ENSMUSG00000041560';
my $member_adaptor = $registry->get_adaptor('Multi', 'compara', 'Member');
my $member = $member_adaptor->fetch_by_source_stable_id('ENSEMBLGENE',$geneName);


###### At the Family level######

my $family_adaptor = $registry->get_adaptor('Multi','compara','Family');
my $families = $family_adaptor->fetch_all_by_Member($member);

foreach my $family (@{$families}) {
    print join(" ", map { $family->$_ }  qw(description description_score))."\n";

    foreach my $member_1 (@{$family->get_all_Members}) {
        print $member_1->stable_id," ",$member_1->taxon_id,"\n";
    }
}

###### At the homology level ######

my $homology_adaptor = $registry->get_adaptor('Multi', 'compara', 'Homology');
my $homologies = $homology_adaptor->fetch_all_by_Member($member);

foreach my $homology (@{$homologies}) {
	print $homology->description," ", $homology->subtype, "\n";  
}




