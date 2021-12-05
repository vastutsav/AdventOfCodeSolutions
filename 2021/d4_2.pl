#!/usr/bin/perl

use warnings;
use strict;

my @numbers = split(/,/, <>);
my @boards;
my @board;
my $winnernum;
my $winnerboard;

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
	my $flag = 0;
	my $cnt = 0;
	$winnernum = $num;
	for (my $p = 0; $p<=$#boards; ++$p) {
		my $lboard = $boards[$p];
		for my $i(0 .. 4) {
			for my $j(0 .. 4) {
				$lboard->[$i][$j] = -1 if ($lboard->[$i][$j] == $num);
			}
		}
	}
	# check rows in each table
	for (my $p = 0; $p<=$#boards; ++$p) {
		my $lboard = $boards[$p];
		for my $i(0 .. 4) {
			$cnt = 0;
			for my $j(0 .. 4) {
				last unless $lboard->[$i][$j] == -1;
				++$cnt;
			}
			if ($cnt == 5) {
				$flag = 1 if $#boards == 0;
				splice (@boards, $p, 1) if $#boards > 0; # removing the board
				last;
			}
		}
	}
	last if $flag == 1;

	# check cols in each table
	for (my $p = 0; $p<=$#boards; ++$p) {
		my $lboard = $boards[$p];
		for my $i(0 .. 4) {
			$cnt = 0;
			for my $j(0 .. 4) {
				last unless $lboard->[$j][$i] == -1;
				++$cnt;
			}
			if ($cnt == 5) {
				$flag = 1 if $#boards == 0;
				splice(@boards, $p, 1) if $#boards > 0; # removing the winner board
				last;
			}
		}
	}
	last if $flag == 1;
}

my $sum = 0;
for my $i (0 .. 4) {
	for my $j (0 .. 4) {
		$sum+=$boards[0]->[$i][$j] if $boards[0]->[$i][$j] != -1;
	}
}

print $sum * $winnernum, " Part 2\n";

