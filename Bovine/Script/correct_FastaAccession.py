"""
	Removes the trailing text from FASTA accession
"""

def readFasta(fastaFile,out_fasta):
    f_in = open(fastaFile,'r')
    f_out = open(out_fasta,'w')

    for line in f_in:
        if line.startswith('>'):
            head = line.split()
            f_out.write(head[0] + '\n')
        else:
            f_out.write(line)

    f_in.close()
    f_out.close()

if __name__=="__main__":
	input_fasta = "../sequenceStorage/Bos_taurus_UMD_3.1.1_genomic.fna"
	output_fasta = "../sequenceStorage/Bos_taurus_UMD_3.1.1_genomic_access.fna"
	readFasta(input_fasta,output_fasta)
