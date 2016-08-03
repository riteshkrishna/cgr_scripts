__author__ = 'Jyan Roynson'
import argparse
import os
import multiprocessing
parser = argparse.ArgumentParser(description="Process command input")
parser.add_argument("forward", metavar="Forward read file", type=str, help="The forward read file in fastq format")
parser.add_argument("reverse", metavar="Reverse read file", type=str, help="The reverse read file in fastq format")
parser.add_argument("outname", metavar="analysis name", type=str, help="Name of the analysis - use watkins ID")
parser.add_argument("reference", metavar="Reference genome", type=str, help="reference genome file in fasta format")
parser.add_argument("-proc", action="store", default=20)
parser.add_argument("-snpnum", action="store", default=9000)
args = parser.parse_args()


#def worker(com):
#    """runs the command item in os.system"""
#    os.system(com)


#unzips = ["gunzip -c {0} | sed 's/ /_/' > {1}_Processed_fastq1".format(args.forward, args.outname), "gunzip -c {0} | sed 's/ /_/' > {1}_Processed_fastq1".format(args.reverse, args.outname)]

#if __name__ == '__main__':
#    jobs = []
#    for item in unzips:
#        p = multiprocessing.Process(target=worker, args=(item,))
#       jobs.append(p)
#        p.start()

#os.system("java -jar /pub6/kate/lamotrigine/Trimmed/virusfinder/VirusFinder2.0/bin/CreateSequenceDictionary.jar R= {0} O= {1}.dict".format(args.reference, args.reference.rstrip('.fasta')))

#os.system("/pub34/laura/bwa-0.7.10/bwa index -a bwtsw {0}".format(args.reference))

os.system("/pub34/laura/bwa-0.7.10/bwa mem -t {0} -R '@RG\\tID:Unknwn\\tPL:Illumina\\tLB:library\\tSM:Unknown' -M {1} {2} {3} | \
awk '$1 ~ /^@/ || $2 == 65 || $2 == 129 || $2 == 67 || $2 == 131 || $2 == 113 || $2 == 177 || $2 == 81 || $2 == 161 || $2 == 163 || $2 == 83 || $2 == 97 || $2 == 145 || $2 == 99 || $2 == 147 || $2 == 137 || $2 == 73 {{print $0}}'  > {4}_filter.sam".format(args.proc, args.reference, args.forward, args.reverse, args.outname))
os.system("samtools view -u -q 10 -T {0} {1}_filter.sam | samtools sort - {1}_sort ; samtools index {1}_sort.bam".format(args.reference, args.outname))
os.system("java -jar -Xmx10g /pub35/xliu/software/picard-tools-1.85/MarkDuplicates.jar I= {0}_sort.bam O= {0}_remove_dups.bam M=duplication.txt REMOVE_DUPLICATES=true AS=true MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000".format(args.outname))
os.system("samtools sort {0}_remove_dups.bam {0}_remove_dups_sort ; samtools index {0}_remove_dups_sort.bam".format(args.outname))

os.system("perl /pub34/laura/coverageStatsSplitByChr_v2.pl -i {0}_remove_dups_sort.bam > {0}_coverage".format(args.outname))

os.system("samtools mpileup -f {0} {1}_remove_dups_sort.bam > {1}_raw.pileup".format(args.reference, args.outname))
os.system("awk '$4 != 0 {{print $0}}' {0}_raw.pileup > {0}_final.pileup".format(args.outname))
os.system("echo \"Number of mapped bases at 5X or more:\" >> {0}_Coverage_stats".format(args.outname))
os.system("awk '$4 >= 5 {{print $0}}' {0}_final.pileup | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of mapped bases at 10X or more:\" >> {0}_Coverage_stats".format(args.outname))
os.system("awk '$4 >= 10 {{print $0}}' {0}_final.pileup | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Average % coverage of reference contigs:\" >> {0}_Coverage_stats".format(args.outname))
os.system("awk '{{sum=sum+$4}} END {{print sum/NR}}' {0}_coverage >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Average depth of coverage of reference contigs:\" >> {0}_Coverage_stats".format(args.outname))
os.system("awk '{{sum=sum+$5}} END {{print sum/NR}}' {0}_coverage >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of mapped reads 1st pass:\" >> {0}_Coverage_stats".format(args.outname))
os.system("grep -v \"^@\" {0}_filter.sam | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of uniquely mapped reads:\" >> {0}_Coverage_stats".format(args.outname))
os.system("samtools view {0}_sort.bam | grep -v \"^@\" | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of uniquely mapped reads after remove duplicates:\" >> {0}_Coverage_stats".format(args.outname))
os.system("samtools view {0}_remove_dups_sort.bam | grep -v \"^@\" | wc -l >> {0}_Coverage_stats".format(args.outname))

os.system("java -jar /pub35/xliu/software/GATK_3_5/GenomeAnalysisTK.jar -R {0} -I {1}_remove_dups_sort.bam -T RealignerTargetCreator -o {1}_target.intervals".format(args.reference, args.outname))
os.system("java -jar /pub35/xliu/software/GATK_3_5/GenomeAnalysisTK.jar -R {0} -I {1}_remove_dups_sort.bam -T IndelRealigner -targetIntervals {1}_target.intervals -o {1}_cleaned.bam".format(args.reference, args.outname))

os.system("samtools sort {0}_cleaned.bam {0}_cleaned_sort ; samtools index {0}_cleaned_sort.bam".format(args.outname))
os.system("java -jar /pub35/xliu/software/GATK_3_5/GenomeAnalysisTK.jar -R {0} -I {1}_cleaned_sort.bam -T UnifiedGenotyper -stand_call_conf 20.00 -o {1}.raw.vcf".format(args.reference, args.outname))
os.system("java -jar /pub35/xliu/software/GATK_3_5/GenomeAnalysisTK.jar -R {0}  -T VariantFiltration --variant {1}.raw.vcf -o {1}_vfallelecalls.vcf --clusterSize 3 --clusterWindowSize 10 --filterExpression \"MQ0 >= 4 && ((MQ0 / (1.0 * DP)) > 0.1)\" --filterName \"HARD_TO_VALIDATE\" \
--filterExpression \"DP < 5 || QUAL < 30.0 || QD < 1.5\" --filterName \"DodgySNPs\" --genotypeFilterExpression \"isHet == 1\" --genotypeFilterName Heterozygote --genotypeFilterExpression \"isHomVar == 1\" --genotypeFilterName Homozygote --genotypeFilterExpression \"isHomRef == 1\" --genotypeFilterName HomozygoteRef".format(args.reference, args.outname))
os.system("java -jar /pub35/xliu/software/GATK_3_5/GenomeAnalysisTK.jar -R {0} -I {1}_cleaned_sort.bam -T UnifiedGenotyper -stand_call_conf 20.00 -glm INDEL -minIndelCnt 5 -o {1}.raw_indel.vcf".format(args.reference, args.outname))
os.system("java -jar /pub35/xliu/software/GATK_3_5/GenomeAnalysisTK.jar -R {0}  -T VariantFiltration --variant {1}.raw_indel.vcf -o {1}_vfindelcalls.vcf --clusterSize 3 --clusterWindowSize 10 --filterExpression \"MQ0 >= 4 && ((MQ0 / (1.0 * DP)) > 0.1)\" --filterName \"HARD_TO_VALIDATE\" --filterExpression \"DP < 5 || QUAL < 30.0 || QD < 1.5\" --filterName \"Dodgyindels\"".format(args.reference, args.outname))
os.system("echo \"Final number of mapped reads:\" >> {0}_Coverage_stats".format(args.outname))
os.system("samtools view {0}_cleaned_sort.bam | grep -v \"^@\" | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of SNPs:\" >> {0}_Coverage_stats".format(args.outname))
os.system("grep \"PASS\" {0}_vfallelecalls.vcf | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of homozygous SNPs:\" >> {0}_Coverage_stats".format(args.outname))
os.system("grep \"PASS\" {0}_vfallelecalls.vcf | grep \"Homozygote:\" | wc -l >> {0}_Coverage_stats".format(args.outname))
os.system("echo \"Number of Indels:\" >> {0}_Coverage_stats".format(args.outname))
os.system("grep \"PASS\" {0}_vfindelcalls.vcf | wc -l >> {0}_Coverage_stats".format(args.outname))







