#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my %rules;
my $str = <>;
my $str1 = $str;
my %pair;
chomp $str;

while (<>) {
	next unless /->/;
	chomp;
	my ($key, $value) = split / -> /;
	$rules{$key} = $value;
}

for my $i (0..(length($str)-2)) {
	$pair{substr($str,$i,2)}++;
}

for (0..39) {
	my %tmpPair;
	for my $k (keys %pair){
		my ($c1, $c2) = split //,$k;
		my $len = length $k;
		# print "<$c1>  <$c2> $len\n";
		my $newCh = $rules{$k};
		$tmpPair{$c1.$newCh}+=$pair{$k};
		$tmpPair{$newCh.$c2}+=$pair{$k};
		# print "<$c1-$newCh> <$newCh-$c2>\n";
	}
	%pair = %tmpPair; 
}

my %freq2;
foreach my $k (keys %pair) {
	my ($c1, $c2) = split //,$k;
	$freq2{$c1}+=$pair{$k};
	$freq2{$c2}+=$pair{$k};
}
$freq2{substr($str,0,1)}++;
$freq2{substr($str,-1,1)}++;

for (0..9) {
	my $tmp = "";
	for my $i (0..(length($str)-2)) {
		$tmp = $tmp.substr($str,$i,1).$rules{substr($str,$i,2)};
	}
	$tmp=$tmp.substr($str,-1);
	$str = $tmp;
}




my %freq;
$freq{$_}++ foreach(split //,$str);

my @arr1 = sort {$a<=>$b} values %freq;
my @arr2 = sort {$a<=>$b} values %freq2;

print $arr1[-1] -  $arr1[0], " Part 1\n";
print $arr2[-1]/2 -  $arr2[0]/2, " Part 2\n";
