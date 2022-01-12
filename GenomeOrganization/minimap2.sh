#Generate alignment of long-read assemblies in .paf format
#conda activate minimap
minimap2 $1 $2 > $1.$2.paf
