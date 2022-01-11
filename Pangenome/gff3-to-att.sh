#Convert .gff3 from Fungap pipeline to .attribute for Pangloss pipeline
#Replace iso with in file with name
#get lines for genes only (i.e. no exons, cds, mrna)
grep "prediction_source" iso.gff3 > iso.att1

#remove columns for source (2), feature (3), score (6), sense (7), strand (8)
awk '{print $1,$9,$4,$5,$9}' iso.att1 > iso.att2

#replace ID= with iso| , need to change iso name
sed 's/ID=/iso|/g' iso.att2 > iso.att3

#add iso identifier column, need to change iso name
sed 's/$/\tiso/' iso.att3 > iso.att4

#replace ; with a space to breakup id and annotation
sed 's/;/ /g' iso.att4 > iso.att5

#move annotation 
awk '{print $1,$2,$3,$4,$5,$7,$8}' iso.att5 > iso.att6
awk '{print $1,$2,$4,$5,$6,$7}' iso.att6 > iso.att7
tr ' ' \\t < iso.att7 >  iso.att8

#convert the id column to match prot db
sed 's/\(|gene_.....\)/\1.t1/g' iso.att8 > iso.attributes

#remove intermediate files
rm iso.att1 iso.att2 iso.att3 iso.att4 iso.att5 iso.att6 iso.att7 iso.att8
