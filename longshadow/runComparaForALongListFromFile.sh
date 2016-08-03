#! /bin/bash           

fileName="Hum-Chim-Gib-Hor-Dol-Dog-Mou-Opp-Chi-Zeb.txt";

while read line           
do           
    echo -e "$line \ n"
    perl ensembl-compara.pl $line	
           
done <$fileName           
