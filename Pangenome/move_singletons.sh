#Pangloss does not distinguish singletons (genes present in only 1 isolate) from other accessory genes.
#This script goes through current directory, if theres is only a single fasta sequence in the file
#it will COPY it to _singletons directory. Change cp to mv below if you want to move them instead.

#Count '>' in fasta file, if it =1 move to singleton folder, else leave it alone
mkdir _singletons
for file in ./*
do
if [ "$(grep '>' -c $file)" == 1 ];
then 
cp $file _singletons
else echo '$file not moved'
fi
done
