#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper qw(Dumper);

my @numbers = split(/,/, <>);
my @boards;
my @board;
my $winnerboard;
my $winnernum;

# create a list of boards
while (<>) {
	chomp;
	# if there are no numbers in the line then it is the end of a board;
	if ($_ !~ /[0-9]/) {
		# new board found
		my @tmp = @board;
		push @boards, \@tmp;
		@board = ();
		next;
	}
	s/^ //;
	my @items = split " +";
	push @board, \@items;
}

my @tmp = @board;
push @boards, \@tmp;
shift @boards;

foreach my $num (@numbers) {
	my $cnt = 0;
	foreach my $lboard (@boards) {
		for my $i(0 .. 4) {
			for my $j(0 .. 4) {
				$lboard->[$i][$j] = -1 if ($lboard->[$i][$j] == $num);
			}
		}
	}
	# check rows in each table
	foreach my $lboard (@boards) {
		for my $i(0 .. 4) {
			$cnt = 0;
			for my $j(0 .. 4) {
				++$cnt if $lboard->[$i][$j] == -1;
			}
			if ($cnt == 5) {
				$winnerboard = $lboard;
				$winnernum = $num;
				last;
			}
		}
		last if $cnt == 5;
	}
	last if $cnt == 5;

	# check cols in each table
	foreach my $lboard (@boards) {
		for my $i(0 .. 4) {
			$cnt = 0;
			for my $j(0 .. 4) {
				++$cnt  if $lboard->[$j][$i] == -1;
			}
			if ($cnt == 5) {
				$winnerboard = $lboard;
				$winnernum = $num;
				last;
			}
		}
		last if $cnt == 5;
	}
	last if $cnt == 5;

}
my $sum = 0;
for my $i (0 .. 4) {
	for my $j (0 .. 4) {
		$sum+=$winnerboard->[$i][$j] if $winnerboard->[$i][$j] != -1;
	}
}

print $sum * $winnernum, " Part 1\n";

