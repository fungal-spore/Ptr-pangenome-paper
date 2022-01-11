:: RAxML was run with the Windows installation
REM -s sequence file
REM -m model
REM -n outputname
REM -p random seed
REM -T #cores (ie threads)
raxmlHPC-PTHREADS.exe -s tree1.fasta -m GTRCATX -n raxtest -p 10 -T 20
