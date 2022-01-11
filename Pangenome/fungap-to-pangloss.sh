#This script makes use of others in this directory to prepare output of FunGAP for input into Pangloss

#conda activate fungap2
#Run from fungap_out
#search and replace isolatename using line below then bash run.sh
#sed 's/isolatename/newname/g' fungap-to-pangloss.sh > run.sh

cp ~/pangenome/renameheader.pl ./
sed 's/isolate/isolatename/g' renameheader.pl > renameheader-isolatename.pl
cp ~/pangenome/gff3-to-att.sh ./
sed 's/iso/isolatename/g' gff3-to-att.sh > gff3-to-att-isolatename.sh

#get nucleotide output from fungap (only protein by default)
python ~/pangenome/gff3_transcript.py -f /isilon/lethbridge-rdc/users/gourlier/assembly/rop/isolatename/contigs.fa -g fungap_out.gff3 -o isolatename

#edit headers
perl renameheader-isolatename.pl isolatename_gene.fna > isolatename.nucl
perl renameheader-isolatename.pl fungap_out_prot.faa > isolatename.faa

#convert gff3 from fungap into attributes file for pangloss
bash gff3-to-att-isolatename.sh

#move new files into pangloss directory
mv isolatename.attributes isolatename.nucl isolatename.faa /home/AAFC-AAC/gourlier/Pangloss/Ptrset/gm_pred/sets

#copy assembly to pangloss directory and add to genomes list
cp /isilon/lethbridge-rdc/users/gourlier/assembly/rop/isolatename/contigs.fa /home/AAFC-AAC/gourlier/Pangloss/Ptrset/genomes/isolatename.fna
cd /home/AAFC-AAC/gourlier/Pangloss/Ptrset/genomes/
echo "genomes/isolatename.fna" >> genomes.txt

rm renameheader.pl renameheader-isolatename.pl gff3-to-att.sh gff3-to-att-isolatename.sh 
