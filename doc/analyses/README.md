# Analyses

- Last modified: ons sep 27, 2023  02:34
- Sign: nylander

## Working with links instead of files

After the cleaning, we can create links to the cleaned data (instead of
copying) each time we need to re-use them for a task.  At this stage (*if* we
have made md5sum-verified backups), we can also delete the raw data.

Create (symbolic/soft) links from the folder in `$DIR` to the current working directory:

    $ mkdir -p /path/to/folder/where/links/are/to/be/created
    $ cd /path/to/folder/where/links/are/to/be/created
    $ find /path/to/folder/whith/fastq.gz/files/ -type f -name '*.fastq.gz' -exec ln -s {} . \;

## Create a data sheet from the sequence delivery

Many workflows require a data sheet for specifying input data. This script
[create_sample_sheet.pl](https://gist.github.com/nylander/287d1f47c669a350c2e7b97a3da58df5#file-create_sample_sheet-pl)
can help as a start. Steps:

0. Download the script and view options (`create_sample_sheet.pl --help`)
1. Change directory to the delivery folder (e.g., `cd P27213`)
2. Assuming there is a file `00-Reports/*_sample_info.txt`, run the script:
        $ create_sample_sheet.pl 00-Reports/*_sample_info.txt > sample_sheet.tsv
3. Go through the output (`sample_sheet.tsv`), and edit as needed.

## Short-read mapping to reference

We have used, to some success, the nf-co.re/eager
(<https://github.com/nf-core/eager>) pipeline for this task. It was tailored
for low-quality or ancient DNA, but can be used for fresh material (Illumina
fastq) as well.  The workflow includes a cleaning and filtering step, so raw
data can be used as input.

See also: <https://github.com/sanger-tol/readmapping>

### Steps

- Prepare a sample sheet ([example](eager-data.tsv))
- Visit <https://nf-co.re/eager>

### Links

- <https://github.com/nf-core/eager>
- <https://github.com/sanger-tol/readmapping>

