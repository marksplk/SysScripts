#!/usr/bin/perl
#FE Harrell 27Jan04
#J  Horner  28Jan04
require 'getopts.pl';
use File::Basename;
#use strict;

my ($program, $infile, $handle, $outfile);

#=================================================================

$program = "html2twiki";

sub usage {
    die "Usage: $program [-v] [file [output-file]]\n";
}

#=================================================================

&Getopts("v") || &usage;


$infile = shift(@ARGV);
if ($infile)
{
    open(INFILE, $infile) || die "$program: Cannot read from $infile\n";
    $handle = "INFILE";
}
else
{
    $handle = "STDIN";
}

$outfile = shift(@ARGV);
if (!$outfile) {
  if($infile ne "") {    # otherwise uses STDOUT by default
     $outfile = basename($infile, (".html")) . ".txt";
     }
  }

if ($outfile)
{
    open(OUTFILE, ">$outfile") || die "$program: Cannot write to $outfile\n";
    select(OUTFILE);
}

$/ = undef ;    # Change input field separator to empty string
$_ = <$handle>; # Grab entire file

s/[\r\n]/ /gis; # Remove any carriage returns or newlines
s/<!--.*?-->//gi;
s/\s+/ /g;
s/<!DOCTYPE.*?>//gi;
s/<hr>/\n------/gi;
s/<h1.*?>(.*?)<\/h1>/\n---+ $1/gi;
s/<h2.*?>(.*?)<\/h2>/\n---++ $1/gi;
s/<h3.*?>(.*?)<\/h3>/\n---+++ $1/gi;
s/<P.*?>(.*?)<\/p>/\n---+++ $1/gi;
s/<br>/\n\n/gi;
s/<i>/_/gi;
s/<\/i>/_/gi;
s/<b>/*/gi;
s/<\/b>/*/gi;
s/<tt>/=/gi;
s/<\/tt>/=/gi;
s/<pre>/\n<verbatim>/gi;
s/<\/pre>/\n<\/verbatim>/gi;
s/<.?ul>//gi;
s/<.?ol>//gi;
s/<li>/\n   * /gi;
s/<.?li>//g;
s/<a\s+href="?(.*?)"?>(.*?)<\/a>/[[$1][$2]]/gi;
s/<a\s+name="?(.*?)"?>(.*?)<\/a>/[[$1][$2]]/gi;
s/<.?html>//gi;
s/<.?head>//gi;
s/<.?font.*?>//gi;
s/<.?small>//gi;

# Jeff's additions
s/<meta.*?>//gi;
s/<title.*?>.*?<\/title>//gi;
s/<.?body.*?>//gi;
print;

