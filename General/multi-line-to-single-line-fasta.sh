#converts fasta files where sequences are on multiple lines into sequences all on one line
#useful for some file manipulation scripts
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' $1 > $2
