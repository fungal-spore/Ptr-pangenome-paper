#Python scripts for extracting a list of genes from a fasta file
#Current file version should function with phobius.sh

import re
import sys

#Fasta file of sequences to be searched
f1 = open(sys.argv[1], 'r') 
#List of genes to be extracted
f2 = open('hitlist.txt','r')
#Output fastas
f3 = open('all.fa','w')


AI_DICT = {}
for line in f2:
	AI_DICT[line[:-1]] = 1

skip = 0
for line in f1:
    if line[0] == '>': # if a line begins with > (standard in FASTA format)
        IDWithArrow = line # call that line IDWithArrow
        ID = IDWithArrow[1:-1] # Remove the first (">") and last ("\s") pieces of the line, call that new string ID
        # print(ID) # Testing
        if ID in AI_DICT: # If ID is inside AI_DICT 
            f3.write(line) # Write line to file3, ie the parsed data file
            skip = 0
        else:
            skip = 1
    else:
        if not skip:
            f3.write(line)

f1.close()
f2.close()
f3.close()
