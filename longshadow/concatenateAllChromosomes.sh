!/bin/bash

FILES=*.fa.gz

for file in $FILES
do
  gzip -d $file
done

CHRS=*.fa
for chrs in $CHRS
do 
 cat $chrs >> All-chr.txt
done

