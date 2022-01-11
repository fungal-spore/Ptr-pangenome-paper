#Script runs Phobius then parses proteins with signal peptides (i.e. secreted) and no transmembrane domains

#run phobius
perl ~/phobius/phobius.pl -short $1 > $1.phob

#get lines with signal peptide domains
#grep -P "Y" $1.phob > $1.phob.sp

#get lines with signal peptide domains and NO transmembrane domains
grep -P "0\s\sY" $1.phob > $1.phob.sp

#get list of genes from .sp
awk '{print $1}' $1.phob.sp > greplist.txt

#convert list of genes into an array
filename=greplist.txt
declare -a myArray
myArray=(`cat "$filename"`)

#loop through array and print genes into list of grep commands
#this is because the .faa file has longer header names than what are printed by  phobius ID column for thi data set
for (( i = 0 ; i < $(grep -c "|" $1.phob.sp) ; i++))
do
  echo "grep '${myArray[$i]}' $1 >> $1.hitlist" >> catch.sh
done

#run grp list and print out hitlist.txt
#hit list is read by extract.py
bash catch.sh
#remove > from hitlist because extract.py doesn't like them
sed s'/>//'g $1.hitlist > hitlist.txt

#run extraction script which pulls genes from hitlist.txt out of give fasta file
python extract.py $1

cp all.fa secreted_genes.aa
cp hitlist.txt secreted_genes.list
rm all.fa $1.hitlist catch.sh greplist.txt hitlist.txt
