'''
This script take a multi-entry fasta file and split into individual files.
Taken and edited from somewhere online, I can't find og thread again.
use with: python split-mulit-fasta.py -f inputfile.fa
'''
from Bio import SeqIO
import argparse

parser = argparse.ArgumentParser(description="Split the fasta file into individual file with each gene seq")
parser.add_argument('-f', action='store', dest='fasta_file', help='Input fasta file')
result = parser.parse_args()

f_open = open(result.fasta_file, "rU")

for rec in SeqIO.parse(f_open, "fasta"):
   id = rec.id
   seq = rec.seq
   id_file = open(id, "w")
   id_file.write(">"+str(id)+"\n"+str(seq))
   id_file.close()

f_open.close()
