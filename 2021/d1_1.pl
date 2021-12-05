#!/usr/bin/perl

use warnings;
use strict;

my $p = 0;
my $c = 0;
while(<>) {
	chomp;
	++$c if $p < $_;
	$p = $_;
}

print($c-1, "\n");


exit();
