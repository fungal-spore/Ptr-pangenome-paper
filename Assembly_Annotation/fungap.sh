#Fungap command, need conda envs fungap2 active and paths from .bashrc
#See publication for RNA details
#Augustus species selected via option with Fungap
python ~/FunGAP/fungap.py \
 --output_dir ~/predic/isolate/fungap/ \
 --trans_read_1 ~/rna/Ptr-veg_1.fastq \
 --trans_read_2 ~/rna/Ptr-veg_2.fastq \
 --genome_assembly ~/assembly/isolate/spades/contigs.fa \
 --augustus_species botrytis_cinerea \
 --sister_proteome ~/FunGAP/sister_orgs/prot_db.faa \
 --num_cores 80
