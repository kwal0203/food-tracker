#!/usr/bin/perl -w

use strict;

# my $mode = $ARGV[1];
# my $file = $ARGV[0];
# open FILE, '<', $file or die "Couldn't open eatint.txt\n";

my $total   = 0;
my $fat     = 0;
my $sugar   = 0;
my $protein = 0;
my $days    = 0;

my $daily_fat     = 60;
my $daily_sugar   = 247;
my $daily_protein = 90;
my $daily_kj = 7500;

print "Please enter a date (or 'all'): ";
my $file = <STDIN>;
chomp $file;
$file = "$file\.txt";
print "Please enter a mode: ";
my $mode = <STDIN>;

if ($mode == 1) {
    open FILE, '<', $file or die "Couldn't open eatint.txt\n";
    while (my $line = <FILE>) {
        print $line; 
        if ($line =~ /^[a-z]+\s+\d+\s+(\d+)\s+([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2})/i) {
            $total   += $1;
            $fat     += $2;
            $sugar   += $3;
            $protein += $4;
        } elsif ($line =~ /^[a-z]+\s+\(g\)\s+\d+\s+(\d+)\s+([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2})/i) {
            $total   += $1;
            $fat     += $2;
            $sugar   += $3;
            $protein += $4;
        }
    }
    $total   = int($total);
    $fat     = int($fat);
    $sugar   = int($sugar);
    $protein = int($protein);
    print "\n";
    print " --- Today's Totals --- \n";
    print "Protein:    ", $protein."g", " (need ", $daily_protein-$protein, "g)\n";
    print "Fat:        ", $fat."g", " (need ", $daily_fat-$fat, "g)\n";
    print "Sugar:      ", $sugar."g", " (need ", $daily_sugar-$sugar, "g)\n";
    print "Kilojoules: ", $total."kj", " (need ", $daily_kj-$total, "kj)\n";
} elsif ($mode == 2) {
    open FILE, '<', $file or die "Couldn't open eatint.txt\n";
    while (my $line = <FILE>) {
        if ($line =~ /^[a-z]+\s+\d+\s+(\d+)\s+([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2})/i) {
            $total   += $1;
            $fat     += $2;
            $sugar   += $3;
            $protein += $4;
        } elsif ($line =~ /^[a-z]+\s+\(g\)\s+\d+\s+(\d+)\s+([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2})/i) {
            $total   += $1;
            $fat     += $2;
            $sugar   += $3;
            $protein += $4;
        }
    }
    $total   = int($total);
    $fat     = int($fat);
    $sugar   = int($sugar);
    $protein = int($protein);

    print "\n";
    print " --- Today's Totals --- \n";
    print "Protein:    ", $protein."g", " (need ", $daily_protein-$protein, "g)\n";
    print "Fat:        ", $fat."g", " (need ", $daily_fat-$fat, "g)\n";
    print "Sugar:      ", $sugar."g", " (need ", $daily_sugar-$sugar, "g)\n";
    print "Kilojoules: ", $total."kj", " (need ", $daily_kj-$total, "kj)\n";
    print "\n";

    $daily_fat     = $daily_fat - $fat;
    $daily_sugar   = $daily_sugar - $sugar;
    $daily_protein = $daily_protein - $protein;

    if ($daily_fat =~ /-\d+/) {
        $daily_fat = -1 * $daily_fat;
        print "Ate $daily_fat grams too much fat\n";
    } else {
        print "Need to eat $daily_fat grams more fat\n";
    }

    if ($daily_sugar =~ /-\d+/) {
        $daily_sugar = -1 * $daily_sugar;
        print "Ate $daily_sugar grams too much sugar\n";
    } else {
        print "Need to eat $daily_sugar grams more sugar\n";
    }

    if ($daily_fat =~ /-\d+/) {
        $daily_fat = -1 * $daily_fat;
        print "Ate $daily_protein grams too much protein\n";
    } else {
        print "Need to eat $daily_protein grams more protein\n";
    }

    my $fat_percent     = int((($fat*37.7) / $total) * 100);
    my $sugar_percent   = int((($sugar*16.7) / $total) * 100);
    my $protein_percent = int((($protein*16.7) / $total) * 100);

    print "\n";
    print "Fat energy percentage today     $fat_percent%\n";
    print "Sugar energy percentage today   $sugar_percent%\n";
    print "Protein energy percentage today $protein_percent%\n";
} elsif ($mode == 3 and $file eq "all.txt") {
    foreach my $file (glob "*.txt") {
        open FILE, '<', $file or die "Couldn't open eatint.txt\n";
        $days++;
        while (my $line = <FILE>) {
            if ($line =~ /^[a-z]+\s+\d+\s+(\d+)\s+([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2})/i) {
                $total   += $1;
                $fat     += $2;
                $sugar   += $3;
                $protein += $4;
            } elsif ($line =~ /^[a-z]+\s+\(g\)\s+\d+\s+(\d+)\s+([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2}).* ([0-9]{2}\.[0-9]{2})/i) {
                $total   += $1;
                $fat     += $2;
                $sugar   += $3;
                $protein += $4;
            }
        }
        # print $file, "\n";
        close FILE;
    }
    print "\n";
    print " --- Grand Total --- \n";
    print "Days:       $days\n";
    print "Protein:    ", int($protein/$days), " g/day\n";
    print "Fat:        ", int($fat/$days), " g/day\n";
    print "Sugar:      ", int($sugar/$days), " g/day\n";
    print "Kilojoules: ", int($total/$days), " kj/day\n";
}
