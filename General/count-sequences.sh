#Counts the number of sequences in a fasta
grep -c '>' $1 > $1.count
