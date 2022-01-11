# FILENAME: renameheader.pl
# DATE: 2004/1/25
# rename fasta header to number each sequence sequentially, and to prepare for formatdb for BLAST
# Legacy PERL script; use caution when using legacy scripts and check for unintended output in your data prior to widespread use

use strict;

# define variables and initialize
my $line;
my @all;
my $number;
$number = 0;
my $fnumber;

@all = <> ;

foreach $line (@all) {

# get only lines which start with ">"

if ($line =~ /^>.*$/) {
  $number += 1 ;

$fnumber = sprintf "%06d",$number;

#sprintf reformats a string, with %06d meaning;
#   0 - right justify with zeros;
#   6d - an integer up to six spaces wide;
# printf is used to print out, while sprintf is to reformat for internal commands;


# change each FASTA header
# $line =~ s/\>/\>gnl\|benth\|nb$fnumber   /o;

$line =~ s/\>/\>isolate|/o;

} #end if loop
      }
print @all;
