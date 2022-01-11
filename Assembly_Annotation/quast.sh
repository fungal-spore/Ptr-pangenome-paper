#Assembly quality stats generated with quast
quast assembly.fasta

#data aggregation
#go to dir with quast results
cd quast_results/latest

#set current directory path as pathname
pathname=$(pwd)

#set parent directory (i.e. isolate name) to two prev direcotries (quast outputs as ./contiglocation/quast_results/latest)
parent=$(basename $(dirname $(dirname $pathname)))

#append a column at end of report with isolate name (i.e. isolate name)
sed "s/$/\t$parent/" transposed_report.tsv > "iso$parent.tsv"

#move to aggregation folder
mv iso*.tsv ~/assembly/

#move to aggregation folder and combine reports
cd ~/assembly
cat iso*.tsv > all_quast.tsv
