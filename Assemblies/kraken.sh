#Passed raw reads through Kraken to filter out any bacterial or viral reads
~/kraken2/kraken2 --threads 10 --db ~/krakendb/ --paired --unclassified-out ~/kraken_out/iso.fq iso_R1.fq.gz iso_R2.fq.gz --report ~/kraken_out/iso_report.txt > ~/kraken_out/iso.krk
