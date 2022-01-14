#run EffectorP on output from phobius.sh
python2 ~/EffectorP-2.0/EffectorP.py -i $1 -short > $1.epout

#Get a list of effector candidates from .epout file
grep -P 'probability' $1.epout > list.txt
awk '{print $1}' list.txt > greplist.txt

#convert list of genes into an array
filename=greplist.txt
declare -a myArray
myArray=(`cat "$filename"`)

#loop through array and print genes into list of grep commands to pull functional info out of pfam output
for (( i = 0 ; i < $(grep -c "|" greplist.txt) ; i++))
do
  echo "grep '${myArray[$i]}' ~/predic/pfam_all.out >> $1.effector.pfam" >> $1.catch.sh
done
bash $1.catch.sh

#cleanup
cp greplist.txt effector.list
rm list.txt greplist.txt $1.catch.sh
