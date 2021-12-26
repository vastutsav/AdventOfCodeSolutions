#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my @matrix;
my @matrix2;

my $cols;
my $rows = 0;
my $ans1 = 0;
my $ans2 = 0;
my @dirs = (
	[-1,-1], [-1, 0], [-1, 1], 
	[ 0,-1],          [ 0, 1],
	[ 1,-1], [ 1, 0], [ 1, 1]);

sub location{ my ($i, $j) = @_;$i*$cols + $j;}
sub getX{my $loc = shift;int($loc/$cols);}
sub getY{my $loc = shift;$loc%$cols;}

sub disp {
	for my $i (0..$rows-1) {
		for my $j (0..$cols-1) {
			print $matrix[location($i, $j)];
		}
		print "\n";
	}
}

sub flash{
	my $loc = shift;
	return if $matrix[$loc] == 999;
	$matrix[$loc] = 999;
	my $i = getX $loc;
	my $j = getY $loc;
	for my $d (@dirs) {
		my $x = $i + $d->[0];
		my $y = $j + $d->[1];
		next if ($x < 0 || $x >= $rows || $y < 0 || $y >= $cols);
		my $tmp = location($x, $y);
		if ($matrix[$tmp] <= 9) {
			++$matrix[$tmp];
			if ($matrix[$tmp] > 9) {
				flash($tmp);
			}
		}
	}
}

sub step{

	for my $i (0..$rows-1) {
		for my $j(0..$cols-1) {
			++$matrix[location($i, $j)];
		}
	}

	for my $i (0..$rows-1) {
		for my $j(0..$cols-1) {
			my $loc = location($i, $j);
			if ($matrix[$loc] > 9) {
				flash($loc);
			}
		}
	}

	for my $i (0..$rows-1) {
		for my $j (0..$cols-1) {
			my $loc = location($i, $j);
			if ($matrix[$loc] > 9) {
				$matrix[$loc] = 0;
			}
		}
	}
}

while (<>) {
	chomp;
	$cols = length;
	$rows++;
	push @matrix, split //;
}
@matrix2 = @matrix;

for (1..100) {
	step;
	$ans1+=grep {!$_} @matrix;
}

@matrix = @matrix2;

while(1) {
	++$ans2;
	step;
	last if (scalar(grep {$_!=0} @matrix) == 0);
}

print "$ans1 Part 1\n";
print "$ans2 Part 1\n";

