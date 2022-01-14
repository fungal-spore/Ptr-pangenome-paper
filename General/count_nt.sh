#remove headers
grep grep "^[^>;]" $1 > nohead.nt
#count nucleotides
grep -o 'A' nohead.nt | wc -l > a.count
grep -o 'C' nohead.nt| wc -l > c.count
grep -o 'T' nohead.nt | wc -l > t.count
grep -o 'G' nohead.nt | wc -l > g.count
#merge
cat *.count > nt.count
rm a.count c.count t.count g.count nohead.nt
