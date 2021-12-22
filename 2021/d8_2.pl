#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper qw(Dumper);

sub getCommon {
	my $a = shift;
	my $b = shift;
	return scalar grep($a =~ /$_/, split (//,$b));
}

sub decode {
	my ($number, $one, $four) = @_;
	my $len = length $number;
	if ($len == 2) {
		return 1;
	} elsif ($len == 3) {
		return 7;
	} elsif ($len == 4) {
		return 4;
	} elsif ($len == 7) {
		return 8;
	} else {
		my $commonWith1 = getCommon $number, $one;
		my $commonWith4 = getCommon $number, $four;
		if ($len == 5) {
			if ($commonWith1 == 1) {
				if ($commonWith4 == 2) {
					return 2;
				} else { # $commonWith4 == 5
					return 5;
				}
			} else { # $commonWith1 == 2
				return 3;
			}
		} else { # $len == 6
			if ($commonWith1 == 2) {
				if ($commonWith4 == 3) {
					return 0;
				} else { # $commonWith4 == 4
					return 9;
				}
			} else { # $commonWith1 == 1
				return 6;
			}
		}
	}
}

my $result = 0;

while(<>) {
	chomp;
	my ($input, $output) = split /\| /;
	# print "$input=>$output\n";
	my @numbers = split /\s+/, $input;
	my @opNumbers = split /\s+/, $output;
	my $one;
	my $four;
	
	# identify the one and the four
	foreach (@numbers) {
		if (length $_ == 2) {
			$one = $_;
		} elsif (length $_ == 4) {
			$four = $_;
		}
	}
	my $tmpNum = 0;
	foreach (@opNumbers) {
		# print "QWE => $_\n";
		$tmpNum = $tmpNum*10 + decode($_, $one, $four);
	}
	#print "$tmpNum \n";
	$result+=$tmpNum;
}

print "$result Part 2\n";
