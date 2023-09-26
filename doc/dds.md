# Using the dds client

- Last modified: tis sep 26, 2023  03:09
- Sign: JN

## Examples

**Note** You need to supply your registered user, password, and one-time-code
(code send by email) when performing the commands below.
See here for account details: <https://scilifelabdatacentre.github.io/dds_cli/#get-an-account>.

List project content

    $ dds data ls --tree --project snpseq00477
    $ dds data ls --size --project snpseq00477

Download all data

    $ dds data get --get-all --verify-checksum --project snpseq00477

Download specific files

    $ dds data get \
      --source WD-3659/230830_A00181_0675_AHL5YKDRX3/230830_A00181_0675_AHL5YKDRX3_WD-3659_multiqc_report.html \
      --source WD-3659/230830_A00181_0675_AHL5YKDRX3/230830_A00181_0675_AHL5YKDRX3_WD-3659_multiqc_report_data.zip \
      --source WD-3659/230830_A00181_0675_AHL5YKDRX3/SampleSheet.csv \
      --project snpseq00477


## Links

<https://scilifelabdatacentre.github.io/dds_cli/examples/>
