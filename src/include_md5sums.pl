#!/usr/bin/env perl

# Usage: ./include_md5sums.pl fastq2_template_1688643815371.tsv MD5SUMS > PRJEB64125.tsv
# Input: 1. ENA-formatted tsv file, 2. file with "md5sum filename"
# Output: ENA formatted sumbission file
# Version: ons 12 jul 2023 16:27:24
# By: JN

use warnings;
use strict;
use File::Basename;

my %md5_hash = (); # Key: fastq file, value: md5sum

my $table = shift;
my $md5sums = shift;

open my $MF, "<", $md5sums or die;
while (<$MF>) {
    chomp;
    my ($md5sum, $fastq) = split /\s+/, $_;
    $md5_hash{$fastq} = $md5sum;
}
close($MF);

open my $TF, "<", $table or die;
while (<$TF>) {
    chomp;
    if (/^FileType/) {
        print $_, "\n";
    }
    elsif (/^sample/) {
        print $_, "\n";
    }
    else {
        my (@line) = split /\t/, $_;
	my $fq1 = basename($line[8]);
        if (exists $md5_hash{$fq1}) {
            $line[9] = $md5_hash{$fq1};
            $line[8] = $fq1;
        }
        else {
            die "Filename does not exists: $line[8].\n";
        }
	my $fq2 = basename($line[10]);
        if (exists $md5_hash{$fq2}) {
            $line[11] = $md5_hash{$fq2};
            $line[10] = $fq2;
        }
        else {
            die "Filename does not exists: $line[10].\n";
        }
        my $new_line = join("\t", @line);
        print $new_line, "\n";
    }
}

