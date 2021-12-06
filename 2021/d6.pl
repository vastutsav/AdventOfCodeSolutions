#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);


my @aquarium = (0) x 9;
my $sum = 0;
$aquarium[$_]++ foreach (split ",", <>);

#print Dumper \@aquarium;
@aquarium = (@aquarium[1..6], $aquarium[0] + $aquarium[7], $aquarium[8], $aquarium[0]) for (1..256);
$sum+=$_ foreach(@aquarium); 
print $sum, " Part 2\n";
