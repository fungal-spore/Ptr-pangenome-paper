#Polish the PacBio Flye assemblies with illumina hi-seq reads

#Map Illumina reads to Flye assembly using Bowtie2
#index reference genome ~ fasta file assembly from Flye
conda activate bowtie2
bowtie2-build assembly.fasta isolate

#align raw illumina reads to indexed flye assembly
#tons of options @ http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#the-bowtie2-build-indexer
bowtie2 -x isolate -1 isolate_1.fq -2 isoalte_2.fq -q --local -S isolate_flye-illumina-aligned -t -p 10

#Convert output SAM to BAM with samtools
conda activate samtools
samtools view -S -b sample.sam > sample.bam
samtools sort sample.bam -o sample.sorted.bam
samtools index sample.sorted.bam

#Polish w Pilon
#options @ https://github.com/broadinstitute/pilon/wiki/Requirements-&-Usage
# -Xmx##G is how many GB of memory allocated to java, first try topped out @ about 80GB used (allocated 600 to be safe)
java -Xmx600G -jar ~/miniconda3/envs/pilon/share/pilon-1.23-2/pilon-1.23.jar --genome assembly.fasta --bam align.sorted.bam --outdir pilon_out --output isolate --changes -vcf --tracks --threads 20
