#!/usr/bin/perl
use strict;
use warnings;

my $path = "input.txt";
open my $file, '<', $path or die "Could not open $path: $!";

my $fullText = "";
while (my $line = <$file>) {
    chomp $line;
    $fullText .= $line;
}

$fullText =~ s/(don't\(\))(.*?)(do\(\))//g; #Remove this line for Part 1 Solution
my @matches = $fullText =~ /mul\(([0-9]{1,3},[0-9]{1,3})\)/g;

my $count = 0;
while(my $element = shift(@matches)) {
    my @results = split(",", $element);
    $count += $results[0] * $results[1];
}

print "The result is: $count\n";
