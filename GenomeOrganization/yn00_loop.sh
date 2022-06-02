#Loop through directories and run yn00, must have run ParaAT_loop.sh first
for i in ./* ; do
  if [ -d "$i" ]; then
    cd $(basename "$i")
    cd paratout
    cp /isilon/lethbridge-rdc/users/gourlier/yn00/ParaAT2.0/yn00.ctl temp
    #assign paml file name to a variable, only going to work if there is single paml file in dir
    var=$(ls *.paml)
    #used sed to replace empty seqfile string with the file name, here you have to use the double quotes to tell sed to expand variables
    sed "s/seqfile=/seqfile = $var/g" temp > yn00.ctl
    yn00
    cd ..
    cd ..
  fi
done
