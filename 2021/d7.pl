#!/usr/bin/perl

use warnings;
use strict;

my $inpstr = <>;
chomp $inpstr;
my @input = split ",", $inpstr;

my $sum1 = -1;
my $sum2 = -1;

my $max = -1;
my $min = -1;
foreach my $m (@input) {
	my $tmp = 0;
	$max = $m if $max < $m || $max == -1;
	$min = $m if $min > $m || $min == -1;
	foreach my $n (@input) {
		$tmp+=abs($m - $n);
	}
	$sum1 = $tmp  if $sum1 == -1 || $tmp  < $sum1;
}


foreach my $m($min .. $max) {
	my $tmp2 = 0;
	foreach my $n (@input) {
		my $d = abs($m - $n);
		$tmp2+=($d*($d+1)/2);
	}
	$sum2 = $tmp2 if $sum2 == -1 || $tmp2 < $sum2;
}

print "$sum1 Part1\n";
printf "%ld Part2\n", $sum2;
