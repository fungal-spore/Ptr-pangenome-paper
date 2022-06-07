#dump results from prank alignment + codeml dNdS
for i in ./* ; do
  if [ -d "$i" ]; then
    cd $(basename "$i")
    cd prank
    echo $(basename "$i") > parse1
    cat parse1 | while read line; do echo ${line} $(tail -n 1 results.txt) > parse2; done
    cat parse2 >> /isilon/lethbridge-rdc/users/gourlier/yn00/no_para/GSR_ATG/dN.dS.scores.prank.list
    rm parse1 parse2
    cd ..
    cd ..
  fi
done

