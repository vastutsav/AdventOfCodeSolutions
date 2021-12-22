#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my $cnt = 0;
while (<>) {
	chomp;
	my @inparr1 = split /\|/;
	my @inparr2 = split /\s+/, $inparr1[1];
	# print @inparr2 , "\n";
	# print Dumper @inparr2;
	foreach (@inparr2) {
		if (length $_ == 2 || length $_ == 3 || length $_ == 4 || length == 7) {
			++$cnt;
		}
	}
}

print "$cnt\n";

