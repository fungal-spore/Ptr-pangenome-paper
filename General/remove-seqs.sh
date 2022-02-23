#store seq ids for removal in ids.txt 

awk 'BEGIN{while((getline<"ids.txt")>0)l[">"$1]=1}/^>/{f=!l[$1]}f' seq.fa > out.fa
