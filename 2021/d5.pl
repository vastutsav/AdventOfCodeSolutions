#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my %hash1;
my %hash2;
my $cnt1 = 0;
my $cnt2 = 0;
while (<>) {
	my ($x1, $y1, $x2, $y2) = /\d+/g;

	if ($x1 != $x2 && $y1 == $y2) {
		($x1, $x2) = ($x2, $x1) if $x1 > $x2; 
		for (my $x = $x1; $x <= $x2; ++$x) {
			$hash1{$x}{$y1}++;
			$hash2{$x}{$y1}++;
		}
	} elsif ($x1 == $x2 && $y1 != $y2) {
		($y1, $y2) = ($y2, $y1) if $y1 > $y2;
		for (my $y = $y1; $y <= $y2; ++$y) {
			$hash1{$x1}{$y}++;
			$hash2{$x1}{$y}++;
		}
	} else {
		my $dx = ($x1 < $x2?  1:
			  $x1 > $x2? -1:
			  0);
		my $dy = ($y1 < $y2?  1:
			  $y1 > $y2? -1:
			  0);
		for (my $x = $x1, my $y = $y1; $x != $x2 && $y != $y2; $x+=$dx, $y+=$dy) {
			$hash2{$x}{$y}++;
		}
		$hash2{$x2}{$y2}++;
	}
}

# print Dumper \%hash1;
foreach my $i (values %hash1) {
	foreach (values %{$i}) {
		$cnt1++ if $_ > 1;
	}
}

foreach my $i (values %hash2) {
	foreach (values %{$i}) {
		$cnt2++ if $_ > 1;
	}
}

print "$cnt1 Part 1\n";
print "$cnt2 Part 2\n";

