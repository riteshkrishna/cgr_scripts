#!/usr/bin/python
import sys, os
'''
    From - http://blog.nextgenetics.net/?e=8
'''

if len(sys.argv) == 1:
    print ''
    print 'Function: Blast a fasta file against another'
    print ''
    print 'Usage: blast_FaToFa [sequenceA.fasta] [sequenceB.fasta] [sequenceB type: n (nucleotide) p(protein)] [blast program: blastn, tblasx, blastp, blastx, tblastn] [evalue] [output]'
    print ''
    sys.exit()

if len(sys.argv) > 1 and len(sys.argv) < 5:
    print 'incorrect number of parameters'

queryFile = sys.argv[1]
dbFile = sys.argv[2]
baseType = sys.argv[3]
blastProgram = sys.argv[4]
evalue = sys.argv[5]
outFile = os.path.abspath(os.path.dirname(sys.argv[6])) + "/" + sys.argv[6].split('/').pop()

if baseType == 'p':
    baseType = 'prot'
elif baseType == 'n':
    baseType = 'nucl'
else:
    print 'wrong paramter for base type'
    sys.exit()

makedbcmd = 'makeblastdb -in ' + dbFile + ' -dbtype ' + baseType + ' -title temp -out ' + sys.path[0] + '/temp/tempDB'
blastdbcmd = blastProgram + ' -query ' + queryFile + ' -db ' + sys.path[0] + '/temp/tempDB -evalue ' + evalue + ' -outfmt 6 -out ' + sys.path[0] + '/temp/blast.out -num_threads 4 -max_target_seqs 20'
blastindexcmd = 'blastdbcmd -db ' + sys.path[0] + '/temp/tempDB -dbtype ' + baseType + ' -entry all -out ' + sys.path[0] + '/temp/tempDB.out'

print 'making blast database'
print makedbcmd
os.system(makedbcmd)

print 'creating index'
print blastindexcmd
os.system(blastindexcmd)

print 'blasting fasta files'
print blastdbcmd
os.system(blastdbcmd)

#print 'creating index'
#os.system(blastindexcmd)

os.system('grep "^>" ' + sys.path[0] + '/temp/tempDB.out | tr -d ">" > ' + sys.path[0] + '/temp/tempDB2.out')
index = dict([(line.strip().split(' ',1)[0],line.strip().split(' ',1)[1]) for line in open(sys.path[0] + "/temp/tempDB2.out",'r').read().strip().split('\n')])

blastResult = open(sys.path[0] + '/temp/blast.out','r')
finalFile = open(outFile,'a')

for line in blastResult:
    data = line.split('\t')
    data[1] = index[data[1]]

    finalFile.write('\t'.join(data) + "\n")

blastResult.close()
finalFile.close()



