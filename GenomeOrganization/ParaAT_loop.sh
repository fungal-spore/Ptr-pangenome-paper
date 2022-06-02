#Loop through folders and perform ParaAT into PAML format on GDR_pairs.nt
for i in ./* ; do
  if [ -d "$i" ]; then
    cd $(basename "$i")
    rm -r paratout
    cp ~/yn00/ParaAT2.0/proc proc
    bash ~/yn00/ParaAT2.0/ParaAT.sh
    cd ..
  fi
done
