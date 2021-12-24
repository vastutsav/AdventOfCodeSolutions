#!/usr/bin/env perl

use warnings;
use strict;

 

use Data::Dumper qw(Dumper);

my @matrix;
my @matrix2;
while(<>){
	chomp;
	my @tmp1 = split //;
	my @tmp2 = @tmp1;
	my @tmp3 = @tmp1;
	push @matrix, \@tmp2;
	push @matrix2, \@tmp3;
}

# print Dumper \@matrix;

my $rows = scalar @matrix;
my $cols = scalar @{$matrix[0]};
my $cnt = 0;
my $lowestPointLabel = 10;

sub floodFill {
        my ($i, $j, $l) = @_;
        return if ($matrix2[$i][$j] >= 9);
        $matrix2[$i][$j] = $l;
        floodFill($i+1, $j, $l) unless $i == $rows-1;
	floodFill($i-1, $j, $l) unless $i == 0;
	floodFill($i, $j+1, $l) unless $j == $cols-1;
	floodFill($i, $j-1, $l) unless $j == 0;
}

for my $i (0..$rows - 1) {
	for my $j (0..$cols - 1) {
		my ($l, $r, $u, $d) = 0;
		$u = ($i != 0)? $matrix[$i-1][$j]:99;
		$d = ($i != ($rows - 1))? $matrix[$i+1][$j]:99;
		$l = ($j != 0)? $matrix[$i][$j-1]:99;
		$r = ($j != ($cols - 1))? $matrix[$i][$j+1]:99;
		
		if ($u > $matrix[$i][$j] && 
			$d > $matrix[$i][$j] && 
			$l > $matrix[$i][$j] && 
			$r > $matrix[$i][$j]) {
			$cnt+=($matrix[$i][$j] + 1);
			floodFill($i, $j, $lowestPointLabel);
			$lowestPointLabel++;
		}
	}
}

my %basinSize;

for my $i (0..$rows - 1) {
	for my $j (0..$cols - 1) {
		if ($matrix2[$i][$j] > 9) {
			$basinSize{$matrix2[$i][$j]}++;
		}
	}
}
my @arr = sort {-$a <=> -$b} values %basinSize;

print "$cnt Part 1\n";
print $arr[0]*$arr[1]*$arr[2], " Part 2\n";

