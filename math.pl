#!/usr/bin/perl

$sum = 0;
for (my $var = 0; $var < $ARGV[0]; $var++) {
    $x = rand;
    $y = rand;
    $sum++ if ($x*$x+$y*$y < 1);
}

print $sum . "\n";
