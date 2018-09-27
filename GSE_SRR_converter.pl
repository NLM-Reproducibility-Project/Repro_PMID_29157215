#!/usr/bin perl

use warnings;

# parses SraRunTable for GEO Accession 'GSE' and 'SRR' Accession(s)
# adds 'SRR' Accession(s) to GSM summary table
# based on matching the unique GSM identifier

# USAGE: perl GSE_SRR_converter.pl SRARUNTABLE.TXT GSM.TXT OUTPUT.TXT

$sra_table = $ARGV[0];
$gsm_table = $ARGV[1];
$new_gsm_table = $ARGV[2];

my $srr;
my %map = ();
my $gsm_line;
my $key;
my $match;


open (SRA, "<", "$sra_table") or die "Can't find $sra_table\n";
open (GSM, "<", "$gsm_table") or die "Can't find $gsm_table\n";
open (NEW_GSM, ">", "$new_gsm_table") or die;

while (<SRA>) {
	if (/(SRR\d+)\sSRS\d+\s(GSM\d+)/) {
		$srr = $1;
		$map{$srr} = $2;
	}
}

while (<GSM>) {
	chomp;
	$gsm_line = $_;
	foreach $key (sort keys %map) {
		$match = $map{$key};
		if ($gsm_line =~ m/$match/) {
			print NEW_GSM "$gsm_line"."\t"."$key\n";
		}
	}
}

close SRA;
close GSM;
close NEW_GSM;