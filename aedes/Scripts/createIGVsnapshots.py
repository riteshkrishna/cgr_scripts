__author__ = 'ritesh'

"""
    The script will produce an IGV-batch file for producing snapshots for various contigs.
"""

if __name__=="__main__":

    # User specified - Name of the genome as specified in IGV
    genome     = "AedesAegypti"

    # User specified - List of BAM files that need to viewed. The file names are seperated by a comma, and there shouldn't be any space around the comma
    bam_file   = "/pub9/ritesh/Aedes_Aegypti/BowtieMappings_single/round2_mapping/SRA_data/FEMALE_SRA.sorted.bam,/pub9/ritesh/Aedes_Aegypti/BowtieMappings_single/round2_mapping/SRA_data/MALE_SRA.sorted.bam"

    # User specified - The directory where the snapshots will be stored
    snapshot_dir = "/pub9/ritesh/Aedes_Aegypti/Analysis/round2_distance_based_contig_selection"

    # User specified - Name of file that contains a list of contigs. One contig per line.
    contigFile = "/pub9/ritesh/Aedes_Aegypti/Analysis/round2_distance_based_contig_selection/round2_CGR_VT_OutOfTop_200.txt"

    # User specified - Name of the IGV batch to produce
    igvBatchFile = "/pub9/ritesh/Aedes_Aegypti/Analysis/round2_distance_based_contig_selection/round2_IGV_CGR_VT_OutOfTop_200.txt"

    f_in = open(contigFile,'r')
    f_out = open(igvBatchFile,'w')

    f_out.write('new \n')
    f_out.write('load ' + bam_file + '\n')
    f_out.write('snapshotDirectory ' + snapshot_dir + '\n')
    f_out.write('genome ' + genome + '\n')

    for line in f_in:
        if line.startswith('##'):
                continue
        f_out.write('goto ' + line.rstrip() + '\n')
        f_out.write('sort base \n')
        f_out.write('collapse \n')
        f_out.write('snapshot \n')

    f_in.close()
    f_out.close()

