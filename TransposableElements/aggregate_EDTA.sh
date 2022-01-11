#Aggregate TE data from EDTA output *.sum file

#set current directory path as pathname
pathname=$(pwd)

#set parent as directory name which is isolate name
parent=$(basename $pathname)

#print summary table, lines 5 to 32 for Ptr (number of lines would change if there are more classes to TE's found)
sed -n 5,32p *.sum > table.catch

#append a column at front of report with isolate name (i.e. isolate name)
sed "s/^/\t$parent/" table.catch > $parent.TEsummary

#merge with aggregation file
rm table.catch
mv *.TEsummary ~/TE_identify/_summary

#manual formatting in excel then import to R
