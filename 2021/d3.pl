#!/usr/bin/perl


use strict;
use warnings;

my @sum= (0) x 12;
my @gamma = (0) x 12;
my @epsilon = (0) x 12;
my @inputs;
my $count = 0;

my @oxygen;
my @carbon;

# Part 1 Starts
while(<>) {
	++$count;
	chomp;
	push @inputs, $_;

	my @a = split //;
	for (0 .. (scalar(@a)-1)) {
		$sum[$_]+=$a[$_];
	}
}
for (0 .. 11) {
	if ($sum[$_] > ($count/2)) {
		$gamma[$_] = 1;
		$epsilon[$_] = 0;
	} else {
		$gamma[$_] = 0;
		$epsilon[$_] = 1;
	}
}
print oct("0b".join("",@gamma)) * oct("0b".join("",@epsilon)), " Part1\n";

# Part 1 Ends

# Part 2 Starts

@oxygen = @inputs;

for my $i ( 0 .. (length($inputs[0]) - 1)) {
	my @temp;
	my $ones = 0;
	my $ox_bitmask = 0;
	for my $number (@oxygen) {
		$ones+=int(substr($number, $i, 1));
	}
	my $zeros = scalar(@oxygen) - $ones;
	if ($ones >= $zeros) {
		$ox_bitmask = 1;
	} else {
		$ox_bitmask = 0;
	}

	for my $number (@oxygen) {
		if (substr($number, $i, 1) == $ox_bitmask) {
			push @temp, $number;
		}
	}
	@oxygen = @temp;
	if (scalar(@oxygen) == 1) {
		last;
	}
}


@carbon = @inputs;

for my $i ( 0 .. (length($inputs[0]) - 1)) {
	my @temp;
	my $ones = 0;
	my $ca_bitmask = 0;
	for my $number (@carbon) {
		$ones+=int(substr($number, $i, 1));
	}
	my $zeros = scalar(@carbon) - $ones;
	if ($ones >= $zeros) {
		$ca_bitmask = 0;
	} else {
		$ca_bitmask = 1;
	}


	for my $number (@carbon) {
		if (substr($number, $i, 1) == $ca_bitmask) {
			push @temp, $number;
		}
	}
	@carbon = @temp;
	if (scalar(@carbon) == 1) {
		last;
	}
}


print oct("0b".join("",@oxygen)) * oct("0b".join("",@carbon)), " Part2\n";

# Part 2 Ends
