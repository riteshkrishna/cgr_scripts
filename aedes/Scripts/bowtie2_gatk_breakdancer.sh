#!/bin/bash
for i in Sample_1_1  Sample_2_2 Sample_3_3 Sample_4_4 Sample_5_5 Sample_6_6;  

do 

VER=v1.2
PROJECT_ID=LIMS3594
SAMPLE="$i"
PLOIDY=1
PLATFORM_ID=Illumina
PROJDIR=/sol01/home/xliu/LIMS3594_Ellie_Harrison_Variants/Andrew_Spires
READDIR=${PROJDIR}/${SAMPLE}/reads
BAMDIR=${PROJDIR}/${SAMPLE}/BAM
INDEL_OUT=${PROJDIR}/${SAMPLE}/INDEL
SNP_OUT=${PROJDIR}/${SAMPLE}/SNP
TMPDIR=${PROJDIR}/${SAMPLE}/tmp
R1=`ls ${READDIR}| grep R1`
R2=`ls ${READDIR}| grep R2`

REF=/sol01/home/xliu/LIMS3594_Ellie_Harrison_Variants/Andrew_Spires/ref/SBW25_012660.fasta
BWA_DB=/sol01/home/xliu/LIMS3594_Ellie_Harrison_Variants/Andrew_Spires/ref/SBW25_012660.fasta

GATK=/pub15/xliu/software/GATK_2_1_3/GenomeAnalysisTK-2.1-13-g1706365/GenomeAnalysisTK.jar

PROC=16
SAMPLE_ID=${PROJECT_ID}_${SAMPLE}

echo "${SAMPLE_ID} STARTED at" `date`
mkdir -p $READDIR $BAMDIR $INDEL_OUT $SNP_OUT $TMPDIR;
bowtie2 -x $BWA_DB --local --sensitive-local -p $PROC -q --fr --rg-id $PROJECT_ID --rg LB:$SAMPLE --rg SM:$SAMPLE --rg PL:$PLATFORM_ID -1 $READDIR/$R1 -2 $READDIR/$R2 | samtools view -bShT $REF -F 4 -q 10 - > $TMPDIR/"$SAMPLE_ID".MQ10.bam



samtools sort $TMPDIR/"$SAMPLE_ID".MQ10.bam $TMPDIR/"$SAMPLE_ID".srt.MQ10
samtools index $TMPDIR/"$SAMPLE_ID".srt.MQ10.bam


#######################
echo "${SAMPLE_ID} Start GATK, local re-alignment..." `date`
java -jar -Xmx36g $GATK -R $REF -I $TMPDIR/"$SAMPLE_ID".srt.MQ10.bam -T RealignerTargetCreator -o $TMPDIR/"$SAMPLE_ID"_target.intervals
java -jar -Xmx36g $GATK -R $REF -I $TMPDIR/"$SAMPLE_ID".srt.MQ10.bam -T IndelRealigner -targetIntervals $TMPDIR/"$SAMPLE_ID"_target.intervals -o $TMPDIR/"$SAMPLE_ID"_realn.bam

samtools sort $TMPDIR/"$SAMPLE_ID"_realn.bam $TMPDIR/"$SAMPLE_ID"_realn.unremove.dup.srt
samtools index $TMPDIR/"$SAMPLE_ID"_realn.unremove.dup.srt.bam 

echo "Total mapped reads (bam files list the mapped reads only" > $TMPDIR/"$SAMPLE_ID".readcount
samtools flagstat $TMPDIR/"$SAMPLE_ID".srt.MQ10.bam  >> $TMPDIR/"$SAMPLE_ID".readcount
echo "" >> $TMPDIR/"$SAMPLE_ID".readcount


echo "${SAMPLE_ID} END of local re-alignment" `date`
#######################

java -Djava.io.tmpdir=/scratch -jar /pub15/xliu/software/picard-tools-1.85/MarkDuplicates.jar ASSUME_SORTED=true MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 I=$TMPDIR/"$SAMPLE_ID"_realn.unremove.dup.srt.bam O=$TMPDIR/"$SAMPLE_ID"_realn.srt.bam SORTING_COLLECTION_SIZE_RATIO=0.25 M=$TMPDIR/duplication.txt REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=LENIENT

samtools index $TMPDIR/"$SAMPLE_ID"_realn.srt.bam

echo "Mapped reads after removing duplicates" >> $TMPDIR/"$SAMPLE_ID".readcount
samtools flagstat $TMPDIR/"$SAMPLE_ID"_realn.srt.bam >> $TMPDIR/"$SAMPLE_ID".readcount
echo "" >> $TMPDIR/"$SAMPLE_ID".readcount

java -jar -Xmx50g /scripts/variant/$VER/tools/BAMStats-1.25/BAMStats-1.25.jar -i $TMPDIR/"$SAMPLE_ID"_realn.srt.bam -o $TMPDIR/"$SAMPLE_ID".BAMstat.txt
MAX_COV=`awk 'BEGIN{mCov=0}{if (NR!=1 && $11 > mCov){mCov=$11}}END{print mCov}' $TMPDIR/"$SAMPLE_ID".BAMstat.txt`

drawbam $TMPDIR/"$SAMPLE_ID"_realn.srt.bam > $TMPDIR/"$SAMPLE_ID"_realn.srt.bam.png

#######################
#echo "GATK"
MIN_INDEL_FRAC=`bc <<< "scale = 10; 0.5 / $PLOIDY "`
java -jar -Xmx50g $GATK -T UnifiedGenotyper -R $REF -I $TMPDIR/"$SAMPLE_ID"_realn.srt.bam -o $TMPDIR/"$SAMPLE_ID"_VARs_raw.vcf -glm BOTH -stand_call_conf 50 -stand_emit_conf 10 -dcov $MAX_COV --max_alternate_alleles 4 --min_base_quality_score 25 -minIndelCnt 2 --sample_ploidy $PLOIDY -gt_mode DISCOVERY -out_mode EMIT_VARIANTS_ONLY -minIndelFrac $MIN_INDEL_FRAC -nt $PROC

cat <(grep '^#' $TMPDIR/"$SAMPLE_ID"_VARs_raw.vcf) <(grep 'Dels' <(grep -v '^#' $TMPDIR/"$SAMPLE_ID"_VARs_raw.vcf)) > $SNP_OUT/"$SAMPLE_ID"_SNPs_raw.vcf

cat <(grep '^#' $TMPDIR/"$SAMPLE_ID"_VARs_raw.vcf) <(grep -v 'Dels' <(grep -v '^#' $TMPDIR/"$SAMPLE_ID"_VARs_raw.vcf)) > $INDEL_OUT/"$SAMPLE_ID"_INDELs_raw.vcf



#######################
#download and build these databases if needed, can't put into single file

java -jar /pub15/xliu/software/snpEff_3_1/snpEff.jar eff pfluo.SBW25.NC_012660 -c /pub15/xliu/software/snpEff_3_1/snpEff.config -no-downstream -no-upstream -no-utr -no-intergenic -s $SNP_OUT/"$SAMPLE_ID"_SNPs_raw.ANNO.html $SNP_OUT/"$SAMPLE_ID"_SNPs_raw.vcf > $SNP_OUT/"$SAMPLE_ID"_SNPs_raw.ANNO.vcf

java -jar /pub15/xliu/software/snpEff_3_1/snpEff.jar eff pfluo.SBW25.NC_012660 -c /pub15/xliu/software/snpEff_3_1/snpEff.config -no-downstream -no-upstream -no-utr -no-intergenic -s $INDEL_OUT/"$SAMPLE_ID"_INDELs_raw.ANNO.html $INDEL_OUT/"$SAMPLE_ID"_INDELs_raw.vcf > $INDEL_OUT/"$SAMPLE_ID"_INDELs_raw.ANNO.vcf


#breakdancer
echo "${SAMPLE_ID} SNPs called, running Breakdancer" `date`
samtools view $TMPDIR/"$SAMPLE_ID"_realn.srt.bam | awk '{if ($3 !~ /\*/) print $0}' - | awk '{if ($6 !~ /\*/)print $0}' - | perl -ne '$a=$_; print "$a" if ($a!~/^\w+\-?\w*\t(101|113|117|119|129|133|135|137|141|145|153|161|165|177|181|183|65|69|71|73|77|81|85|89|97|93|4)\t/)' > $TMPDIR/"$SAMPLE_ID".mapped.remove_singletons.sam

samtools view -uT $REF $TMPDIR/"$SAMPLE_ID".mapped.remove_singletons.sam | samtools sort - $TMPDIR/"$SAMPLE_ID".mapped.remove_singletons.sorted

##run breakdancer
/pub8/stevep11/bin/breakdancer-1.1.2/perl/bam2cfg.pl  -g -h $TMPDIR/"$SAMPLE_ID".mapped.remove_singletons.sorted.bam > $TMPDIR/"$SAMPLE_ID".mapped.remove_singletons.sorted.cgf

/pub8/stevep11/bin/breakdancer_max -g $TMPDIR/"$SAMPLE_ID".gbrowse -a -h $TMPDIR/"$SAMPLE_ID".mapped.remove_singletons.sorted.cgf > $TMPDIR/"$SAMPLE_ID".sorted.cgf.txt

cat <(grep '^#' $TMPDIR/"$SAMPLE_ID".sorted.cgf.txt) <(awk '$9 == 99 {print $0}' $TMPDIR/"$SAMPLE_ID".sorted.cgf.txt) > $TMPDIR/"$SAMPLE_ID".sorted.cgf.99.txt


#pick stuff needed
cp $TMPDIR/"$SAMPLE_ID".readcount ${BAMDIR}/.
cp $TMPDIR/"$SAMPLE_ID"_realn.srt.* ${BAMDIR}/.
cp $TMPDIR/"$SAMPLE_ID".BAMstat.txt ${BAMDIR}/.
cp $TMPDIR/"$SAMPLE_ID".sorted.* $INDEL_OUT/.
cp $TMPDIR/"$SAMPLE_ID".gbrowse $INDEL_OUT/.
mv ./"$SAMPLE_ID"*histogram* $INDEL_OUT/.
done
