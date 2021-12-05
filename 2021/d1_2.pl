#!/usr/bin/perl

use warnings;
use strict;


my $a = <>;
my $b = <>;
my $c = <>;
chomp($a,$b,$c);
my $cnt = 0;
while(<>) {
	chomp;
	++$cnt if ($a + $b + $c) < ($b + $c + $_);
	($a, $b, $c) = ($b, $c, $_);
}

print($cnt, "\n");


exit();
