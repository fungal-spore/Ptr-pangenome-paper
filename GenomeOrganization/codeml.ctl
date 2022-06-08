#Control file for PAML codeml 
seqfile = prank_out.best.nuc.fas
outfile = results.txt   * main result file name
treefile = treefile.txt *tree file
noisy = 9      * 0,1,2,3,9: how much rubbish on the screen
verbose = 1      * 1:detailed output
runmode = -2     * -2:pairwise
seqtype = 1      * 1:codons
CodonFreq = 0      * 0:equal, 1:F1X4, 2:F3X4, 3:F61
model = 0      *
NSsites = 0      *
icode = 0      * 0:universal code
fix_kappa = 0      * 1:kappa fixed, 0:kappa to be estimated
kappa = 0.5      * initial or fixed kappa
fix_omega = 0      * 1:omega fixed, 0:omega to be estimated
omega = 0.5    * initial omega value
