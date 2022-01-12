#Generate syntenic blocks with sibelia for use with Circos plotting
#conda activate sibelia

Sibelia -s loose $1 $2 -m 6500 -o ~/sibelia_output/
