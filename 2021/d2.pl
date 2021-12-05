#!/usr/bin/perl

use warnings;
use strict;

my $h = 0;
my $v1 = 0;
my $v2 = 0;
my $a = 0;

my @inp;
while(<>) {
	chomp;
	@inp = split;
	if($inp[0] eq "forward") {
		$h+=$inp[1];
		$v2 = $v2 + ($inp[1] * $a);
	} elsif ($inp[0] eq "up") {
		$v1-=$inp[1];
		$a-=$inp[1];
	} else {
		$v1+=$inp[1];
		$a+=$inp[1];
	}
}
printf("%ld(h) x %ld(v) = %ld\n", $h, $v1, $h*$v1);
printf("%ld(h) x %ld(v) = %ld\n", $h, $v2, $h*$v2);
