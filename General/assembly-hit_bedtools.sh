#Extract blast hit from an assembly with beds tools
blastn  -query $1 -db $2 -outfmt 6  -evalue 10 > $1.$2.blastout

#Sometimes you get error because strands are reversed, switch comment on the two awk lines and rerun to resolve
awk '{print $2"\t"$10"\t"$9}' $1.$2.blastout > interval.bed
#awk '{print $2"\t"$9"\t"$10}' $1.$2.blastout > interval.bed
bedtools getfasta -fi $2 -bed interval.bed -fo $1.$2.asmb
rm interval.bed
