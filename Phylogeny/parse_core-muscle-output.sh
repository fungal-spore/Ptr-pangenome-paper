#Parse core alignments from muscle output
#Output from muslce is alignment files  for each genes as Core_#.fna.out
#Search and replace isolate with ID;script needs to be run for each isolate

#put all alignments in a single file to parse, only need to run once prior to first isolate
#cat *.out > raw_align

#get list for each genome based on ID (eg broad)
grep 'isolate' raw_align > isolate_align_list
sed s'/>//'g isolate_align_list > hitlist.txt
#run extraction script which pulls genes from hitlist.txt out of give fasta file; extract.py from phobius setup should function here
python ~/scripts/extract.py raw_align

##make sure genes are dumped into file in same order for each genome and remove all headers
grep -v ">"  all.fa > isolate_nohead

#add new isolate specific header: ID_all-core-align_cat
echo ">isolate_race-tox-location" > isolate_head
cat isolate_head isolate_nohead > isolate.aln
rm isolate_align_list hitlist.txt all.fa isolate_nohead isolate_head

#merge all full alignments once done for all isolates
# cat *.aln > all_core.aln
