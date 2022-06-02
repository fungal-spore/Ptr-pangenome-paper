#dump results
for i in ./* ; do
  if [ -d "$i" ]; then
    cd $(basename "$i")
    cd paratout
    echo $(basename "$i") > parse1
    cat parse1 | while read line; do echo ${line} $(tail -n 1 results.txt) > parse2; done
    cat parse2 >> /isilon/lethbridge-rdc/users/gourlier/yn00/GDR_ATG/dN.dS.scores.list
    rm parse1 parse2
    cd ..
    cd ..
  fi
done
