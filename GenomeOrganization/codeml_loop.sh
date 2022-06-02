#Loop through directories and run yn00, must have run ParaAT_loop.sh first
for i in ./* ; do
  if [ -d "$i" ]; then
    cd $(basename "$i")
    cd paratout/
    rm *.dN *.dS *.t 4fold.nuc results.txt rst rst1 rub
    cp /isilon/lethbridge-rdc/users/gourlier/yn00/codeml.ctl temp
    #assign paml file name to a variable, only going to work if there is single paml file in dir
    var=$(ls *.paml)
    #used sed to replace empty seqfile string with the file name, here you have to use the double quotes to tell sed to expand variables
    sed "s/seqfile=/seqfile = $var/g" temp > codeml.ctl
    rm temp
    codeml
    cd ..
    cd ..
  fi
done

