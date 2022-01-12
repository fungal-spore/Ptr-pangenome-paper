#Generate syntenic blocks with sibelia for use with Circos plotting
#Should be able to run simply run Circos from output directory and it will generate plots
#conda activate sibelia

Sibelia -s loose $1 $2 -m 6500 -o ~/sibelia_output/
