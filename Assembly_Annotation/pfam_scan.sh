#Use the pfam script from FunGAP on protein files like represents_accessory.aa and represents_core.aa
pfam_scan.pl -fasta $1 -dir ~/FunGAP/db/pfam
