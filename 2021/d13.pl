#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my %points;
my @folds;
my $ans1 = 0;
my @ans2;
my ($mnx, $mny) = (0, 0);

while (<>) {
	chomp;
	last unless /,/;
	$points{$_} = '*';
}

while (<>) {
	chomp;
	my @tmp = split(/ /, $_);
	push @folds, $tmp[$#tmp];
}



foreach my $f (@folds){
	my %pointsAfterFold;
	my ($axis, $line) = split '=',$f;

	foreach my $p (keys %points) {
		my ($x, $y) = split ",",$p;
		$y = 2*$line - $y if ($y > $line && $axis eq 'y');
		$x = 2*$line - $x if ($x > $line && $axis eq 'x');
		$pointsAfterFold{$x.",".$y} = "*";
	}

	$ans1 = scalar keys %pointsAfterFold if ($ans1 == 0);
	#print Dumper %pointsAfterFold;
	%points = %pointsAfterFold;
}

for (0..50) {
	my @str = (" ") x 50;
	push @ans2,\@str;
}

for (keys %points) {
	my ($x, $y) = split ",";
	$ans2[$x][$y] = "#";
}

print $ans1,"\n";

foreach (@ans2) {
	print "@$_\n";
}
