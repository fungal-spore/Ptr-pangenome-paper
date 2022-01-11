#Script used for assembling short-read illumina hi-seq reads for all Ptr isolates
shovill --outdir ~/assembly/isolate --R1 ~/_raw/isolate_R1.fastq.gz --R2 ~/_raw/isolate_R2.fastq.gz --trim ON --assembler spades
