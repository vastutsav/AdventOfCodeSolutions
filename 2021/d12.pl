#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my %graph;
my %visit;
my %visit2;

sub calc {
	my ($src, %visit) = @_;
	my $ret = 0;

	return 1 if $src eq 'end';

	if ($src eq lc $src) {
		$visit{$src}=1;
	}
	foreach my $nxt (@{$graph{$src}}) {
		next if exists $visit{$nxt};
		$ret += calc($nxt, %visit);
	}
	return ($ret);
}

sub calc2 {
	my ($src, $visitedTwice, %visit) = @_;
	my $ret = 0;

	return 1 if $src eq 'end';

	if ($src eq lc $src) {
		$visit{$src}++;
		$visitedTwice = 1 if ($visit{$src} == 2);
	}

	foreach my $nxt (@{$graph{$src}}) {
		next if (exists $visit{$nxt} && $visitedTwice);
		$ret += calc2($nxt, $visitedTwice, %visit);
	}
	return ($ret);
}

while(<>) {
	chomp;
	my ($a, $b) = split /-/;
	push @{$graph{$a}}, $b unless $b eq 'start' || $a eq 'end';
	push @{$graph{$b}}, $a unless $a eq 'start' || $b eq 'end';
}

# print Dumper %graph; 

my $ans1 = calc('start', %visit);
my $ans2 = calc2('start', 0);

print "$ans1 Part 1\n";
print "$ans2 Part 2\n";

