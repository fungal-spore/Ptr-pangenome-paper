:: RAxML was run with the Windows installation
REM -s sequence file
REM -m model
REM -n outputname
REM -p random seed
REM -T #cores (ie threads)
raxmlHPC-PTHREADS.exe -s all_core.aln -m GTRCATX -n core.phylo -p 10 -T 20
