#! /usr/bin/env perl

=pod

=head1 NAME

create_ENA_fastq_submit.pl - create fastq tsv for ENA

=head1 SYNOPSIS

create_ENA_fastq_submit.pl [options] -m F<MD5SUMS> -t F<fastq2_template_xxxx.tsv> -a F<Webin-accessions.tsv> -s I<PROJID>

=head1 DESCRIPTION

Create ENA fastq submit tsv from other files. More specifically
F<MD5SUMS>, F<fastq2_template_xxxx.tsv>, and  F<Webin-accessions.tsv> (all mandatory options).
In addition, the script needs an ENA project ID (B<-s> option).

Print to outfile (B<-o> option) or STDOUT.

For full details about the submit process to ENA, see L<https://ena-docs.readthedocs.io/en/latest/submit/general-guide.html>

=head1 OPTIONS

=over 8

=item B<-a, --accessions>=F<filename>

File from ENA with sample accessions. Format:

    TYPE    ACCESSION       ALIAS
    SAMPLE  ERS19298585     Sap235
    ...

=item B<-i, --instrument_model>=I<name>

Specify instrument model. See L<https://www.ebi.ac.uk/ena/submit/webin/read-submission>. Default is I<Illumina NovaSeq 6000>.

=item B<--library_layout>=I<name>

Specify library layout. See L<https://www.ebi.ac.uk/ena/submit/webin/read-submission>. Default is I<PAIRED>.

=item B<--library_selection>=I<name>

Specify library selection. See L<https://www.ebi.ac.uk/ena/submit/webin/read-submission>. Default is I<RANDOM>.
'Reduced Representation' may be another option (among several other options).

=item B<--library_source>=I<name>

Specify library source. See L<https://www.ebi.ac.uk/ena/submit/webin/read-submission>. Default is I<GENOMIC>.

=item B<--library_strategy>=I<name>

Specify library strategy. See L<https://www.ebi.ac.uk/ena/submit/webin/read-submission>. Default is I<WGA>.
'Targeted-Capture' may be another option (among several other options).

=item B<-m, --md5sums>=F<filename>

Specify file with md5 sums. Format:

    0a4bf12a1c849fefcac96c72f41f969b  P23358_1066_S265_L003_R1_001.fastq.gz

=item B<-o, --out>=F<filename>

Specify output file. Default output is STDOUT.

=item B<-s, --study>=I<study id>

Specify ENA study ID.

=item B<-t, --template>=F<filename>

Specify file with ENA fastq template header.

=item B<-v, --version>

Print version number and quit.

=item B<-h, --help>

Show this help text and quit.

=back

=head1 VERSION

0.1

=head1 AUTHOR

Johan Nylander

=head1 DOWNLOAD

L<https://github.com/Naturhistoriska/NRM-DNA-lab/src/>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2024 Johan Nylander

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;

my $version = '0.1';
my $PRINT; # Print file handle. Using the typeglob notation below
my $out = q{}; # print to outfile or stdout
my $md5sums = q{}; # file MD5SUMS
my $template = q{}; # file fastq2_template_xxxx.tsv
my $accessions = q{}; # file Webin-accessions.tsv
my $forward_file_pattern = '_R1_001.fastq.gz';
my $reverse_file_pattern = '_R2_001.fastq.gz';

my $sample = q{};
my $study = q{};
my $instrument_model = "Illumina NovaSeq 6000";
my $library_name = q{};
my $library_source = "GENOMIC";
my $library_selection = "RANDOM";
my $library_strategy = "WGA";
my $library_layout = "PAIRED";
my $forward_file_name = q{};
my $forward_file_md5 = q{};
my $reverse_file_name = q{};
my $reverse_file_md5 = q{};

my %a_hash = ();
my %md5_hash = ();
my %accession_hash = ();
my @line = ();
my %HoH = ();
#%HoH = (
#    key => {
#        forward_file   => "",
#        reverse_file   => "",
#        forward_md5   => "",
#        reverse_md5   => "",
#    }
#);

## Get args
exec("perldoc", $0) unless (@ARGV);

GetOptions(
    "accessions=s" => \$accessions,
    "instrument_model=s" => \$instrument_model,
    "library_layout=s" => \$library_layout,
    "library_selection=s" => \$library_selection,
    "library_source=s" => \$library_source,
    "library_strategy=s" => \$library_strategy,
    "md5sums=s" => \$md5sums,
    "out=s" => \$out,
    "study=s" => \$study,
    "template=s" => \$template,
    "version" => sub { print "$version\n"; exit(0); },
    "help" => sub { exec("perldoc", $0); exit(0); },
);

## If outputfile
if ($out) {
    open ($PRINT, '>', $out) or die "$0 : Failed to open output file $out : $!\n\n";
}
else {
    $PRINT = *STDOUT; # Using the typeglob notation in order to use STDOUT as a variable
}

# Check mandatory files
die "ERROR: ENA study is needed. See $0 -h for options.\n" unless ($study);
die "ERROR: MD5SUM file is needed. See $0 -h for options.\n" unless ($md5sums);
die "ERROR: tsv template file is needed. See $0 -h for options.\n" unless ($template);
die "ERROR: ENA accessions file is needed. See $0 -h for options.\n" unless ($accessions);

# Read accessions
#     TYPE    ACCESSION       ALIAS
#     SAMPLE  ERS19298585     Sap235
#     ...
open my $AF, "<", $accessions or die;
while (<$AF>) {
    chomp;
    my ($type, $accession, $alias) = split /\s+/, $_;
    $accession_hash{$alias} = $accession;
}
close($AF);

# Read md5sums
#     0a4bf12a1c849fefcac96c72f41f969b  Sap235_S265_L003_R1_001.fastq.gz
open my $MF, "<", $md5sums or die;
while (<$MF>) {
    chomp;
    my ($md5sum, $fastq) = split /\s+/, $_;
    $md5_hash{$fastq} = $md5sum;
    if ($fastq =~ /$forward_file_pattern/) {
        foreach my $key (keys %accession_hash) {
            if ($fastq =~ /$key/) {
                $HoH{$key}{'forward_file_name'} = $fastq;
                $HoH{$key}{'forward_file_md5'} = $md5sum;
            }
        }
    }
    elsif ($fastq =~ /$reverse_file_pattern/) {
        foreach my $key (keys %accession_hash) {
            if ($fastq =~ /$key/) {
                $HoH{$key}{'reverse_file_name'} = $fastq;
                $HoH{$key}{'reverse_file_md5'} = $md5sum;
            }
        }
    }
}
close($MF);

# Read template
#    FileType	fastq	Read submission file type									
#    sample	study	instrument_model	library_name	library_source	library_selection	library_strategy	library_layout	forward_file_name	forward_file_md5	reverse_file_name	reverse_file_md5
open my $TF, "<", $template or die;
while (<$TF>) {
    chomp;
    print $PRINT "$_\n";
}
close($TF);

# Print all
foreach my $key (sort keys %HoH) {
    print $PRINT $accession_hash{$key}, "\t";
    print $PRINT $study, "\t";
    print $PRINT $instrument_model, "\t";
    print $PRINT $key, "\t";
    print $PRINT $library_source, "\t";
    print $PRINT $library_selection, "\t";
    print $PRINT $library_strategy, "\t";
    print $PRINT $library_layout, "\t";
    print $PRINT $HoH{$key}{'forward_file_name'}, "\t";
    print $PRINT $HoH{$key}{'forward_file_md5'}, "\t";
    print $PRINT $HoH{$key}{'reverse_file_name'}, "\t";
    print $PRINT $HoH{$key}{'reverse_file_md5'};
    print $PRINT "\n";
}

if ($out) {
    close($PRINT);
}

