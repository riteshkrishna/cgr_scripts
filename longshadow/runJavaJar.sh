#!/bin/bash

FILES=*-cds.fa

for FILE in $FILES
do
  java -jar cgr-code.jar $FILE 5 $FILE.-names.txt
done
