#!/usr/bin/env perl

use strict;
use warnings;

my %points;
my @folds;

while (<>) {
	chomp;
	last unless /,/;
	print;
	print "\n";
	$points{$_} = '*';
}

while (<>) {
	chomp;
	my @tmp = split(/ /, $_);
	push @folds, $tmp[$#tmp];
}



print "==========\n";

print @folds;

foreach (keys %points) {
	#	print;
	# print "\n";
}
