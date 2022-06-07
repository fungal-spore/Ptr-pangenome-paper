#loop for folders in dir
for i in ./* ; do
  if [ -d "$i" ]; then
    #move into folder
    cd $(basename "$i")
    #alignment
    prank -d=GSR_pair.nt -o=prank_out -translate -F
    #clean up old codeml run
    #rm *.dN *.dS *.t 4fold.nuc results.txt rst rst1 rub
    #copy codeml control file
    mkdir prank
    cp prank_out.best.nuc.fas prank/prank_out.best.nuc.fas
    cd prank
    #codeml.ctl already configured and set to input prank_out.best.nuc.fas
    cp /isilon/lethbridge-rdc/users/gourlier/yn00/codeml.ctl codeml.ctl
    #run codeml
    codeml
    cd ..
    cd ..
  fi
done
