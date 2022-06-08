while read line
do
   echo $line > gene_pair1
   sed 's/\s/\n/g' gene_pair1 > gene_pair2
   sed 's/|//g' gene_pair2 > gene_pair3
   rm gene_pair2
   mkdir $(awk '{print $1}' gene_pair1)
   python extract.py GDR.nt gene_pair3
   mv all.fa $(awk '{print $1}' gene_pair1)/GDR_pair.nt
   python extract.py GDR.aa gene_pair3
   mv all.fa $(awk '{print $1}' gene_pair1)/GDR_pair.aa
   cp gene_pair1 $(awk '{print $1}' gene_pair1)/pair.list
   rm gene_pair1 gene_pair3
done < GDR_gene_pairs.list
