#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my @opener = ('(', '{', '[', '<');
my @closer = (')', '}', ']', '>');
my %errScore = (')' => 3,
	']' => 57,
	'}' => 1197,
	'>' => 25137);
my %map = (')' => '(',
	'}' => '{',
	']' => '[',
	'>' => '<');
my %acScoreHash = ('(' => 1, '[' => 2, '{' => 3, '<' => 4);
my $syntaxErrScore = 0;
my @acScores = ();
while(<>) {
	chomp;
	my @stack = ();
	my $tmpScore = 0;
	foreach my $op (split //){
		if (grep($_ eq $op, @opener)) {
			push @stack, $op;
		} else {
			if ($map{$op} eq $stack[$#stack]) {
				pop @stack;
			} else {
				$syntaxErrScore+=$errScore{$op};
				@stack = ();
				last;
			}
		}
	}
	while (scalar @stack > 0) {
		my $op = pop @stack;
		$tmpScore = $tmpScore*5 + $acScoreHash{$op};
	}
	push @acScores, $tmpScore if $tmpScore > 0;
}
my @sortedScores = sort {$a <=> $b} @acScores;

print "$syntaxErrScore Part 1\n";
print "$sortedScores[$#sortedScores/2] Part 2\n";

