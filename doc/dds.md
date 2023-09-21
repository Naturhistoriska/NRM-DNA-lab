# Using the dds client

- Last modified: tor sep 21, 2023  03:47
- Sign: JN

## Examples

List project content

    $ dds data ls --tree --project snpseq00477
    $ dds data ls --size --project snpseq00477

Download all data

    $ dds data get --get-all --project snpseq00477

Download specific files

    $ dds data get \
      --source WD-3659/230830_A00181_0675_AHL5YKDRX3/230830_A00181_0675_AHL5YKDRX3_WD-3659_multiqc_report.html \
      --source WD-3659/230830_A00181_0675_AHL5YKDRX3/230830_A00181_0675_AHL5YKDRX3_WD-3659_multiqc_report_data.zip \
      --source WD-3659/230830_A00181_0675_AHL5YKDRX3/SampleSheet.csv \
      --project snpseq00477


## Links

<https://scilifelabdatacentre.github.io/dds_cli/examples/>
