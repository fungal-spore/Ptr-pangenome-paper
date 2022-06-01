#Ryan Gourlie 220601
#Written to help with GDR/GSR work
#Some fasta sequences were reversed but NOT complimented, impossible to find something that just reverse but does not compliment
#wrote this, works for pairs of sequences, not tested on larger fasta files

#Force fasta sequence to a single line
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' GDR_pair.nt > GDR_pair.oneline
#get fasta headers
grep '>' GDR_pair.oneline > headers
#get sequences to be reversed
grep -v '>' GDR_pair.oneline > seqs
#seqs file gets an empty first line, this removes that line
tail -n +2 seqs > seq
#reverse the seq strings
rev seq > seqs.rc
#interleave the header and seqs.rc files to put headers back in place
awk '{print; if(getline < "seqs.rc") print}' headers > GDR_pair.nt
#clean up
rm GDR_pair.oneline headers seqs seq seqs.rc
