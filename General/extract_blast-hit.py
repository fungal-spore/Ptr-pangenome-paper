'''
Purpose of this script is:
-take hits from the .blastout file (created using StandAlone BLAST with argument: -outfmt 7)
-find hits in the queried fasta database and output to file called 'all.fa'
-script split-mutli-fasta.py to cut 'all.fa' into individual files
run using: python extract_blast-hit.py %1 %2
where
%1 = .blastout file (outfmt 7)
%2 = database on which blast was run	
'''
import re
import sys

inputFile = sys.argv[1]	# Universal input, input must be blast output format # 7, outfmt 6 would probably work too but not tested
#inputFile = "10082.PDR1.blastpout" #Test file
database = sys.argv[2]		#Universal input
#database = "10082.aa" #Test database

with open("hitlist.txt", "w") as file:	#Open a writeable file with the name hitlist.txt
	with open(inputFile) as data:	#Open input file which is defined as blast output format 7 above
		for line in data:	# Go through each line in the input file
			gene_names = re.search(r"(([^\s]+)\.t([^\s]+))", line, re.IGNORECASE)	#search for any string of non-white space characters containing '.t', this is added during augustus geneprediction. probably not best way to get, often '|' is used too, this line may need to be altered depending on database
			if gene_names:	#If there is a search match
				hits = gene_names.group(1)	# add the match to the variable hits
				#print(hits) # Testing the search
				print(hits, file=file)	#print hits to file (defined above as hitlist.txt)

# Took below and edited from:
# https://stackoverflow.com/questions/15352219/extract-sequences-from-a-fasta-file-based-on-entries-in-a-separate-file

#f1 = open('10082.aa','r') # Test database input
f1 = open(sys.argv[2], 'r') # Universal input for database
f2 = open('hitlist.txt','r') # provided above, list of gene hits from the blast output
f3 = open('all.fa','w') # Will contain all hits in fasta formated

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
