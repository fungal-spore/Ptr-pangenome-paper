#!/bin/bash

#list of gene names, in this case from using grep 'isoname' from core gene set
FILENAME="iso.core.list"

LINES=$(cat $FILENAME)
COUNTER=0

#Loop through lines of the file, and for each on make a grep command to find gene in attributes file.
for LINE in $LINES
do
    echo "grep '$LINE' iso.attributes >> iso.core.attributes" >> grep.core-attributes.sh
    COUNTER=$((COUNTER+1))
done

#run the grep commands
bash grep.core-attributes.sh

#print the first column (contig#), sort them, count instances, sort be descending order
awk '{print $1}' iso.core.attributes | sort | uniq -c | sort -nr > iso.core.count
rm grep.core-attributes.sh
