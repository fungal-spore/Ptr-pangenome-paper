#Performs same function as first script but removed the awful loop for easier use. 
#Left the old script for posterity/reproducibility.
#Script runs Phobius then parses proteins with signal peptides (i.e. secreted) and no transmembrane domains

#run phobius
#perl ~/phobius/phobius.pl -short $1 > $1.phob

#get lines with signal peptide domains
#grep -P "Y" $1.phob > $1.phob.sp

#get lines with signal peptide domains and NO transmembrane domains
#grep -P "0\s\sY" $1.phob > $1.phob.sp

#get list of genes from .sp
awk '{print $1}' $1.phob.sp > gene-list.txt

#Get full fasta headers
grep -F -f gene-list.txt "$1" > "$1.hitlist"

#remove > from hitlist because extract.py doesn't like them
sed s'/>//'g $1.hitlist > hitlist.txt

#run extraction script which pulls genes from hitlist.txt out of give fasta file
python extract.py $1

cp all.fa $1.secreted_genes.aa
cp hitlist.txt $1.secreted_genes.list
rm all.fa $1.hitlist gene-list.txt hitlist.txt
