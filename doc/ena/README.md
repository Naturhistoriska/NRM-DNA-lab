# ENA Data Submission

- Last modified: mån apr 22, 2024  04:41
- Sign: nylander

## Description

In addition to the fastq files that needs to be submitted, we need metadata
information (for the fastq files), but also information on the study from the
PI. The necessary pices of information is listed below. For details on the
checklist, see below.

- [ ] Sample sheet from PI (see [metadata](../metadata/README.md))
- [ ] Location of fastq files (most probably on nrmdna01.nrm.se)
- [ ] Release date (se notes below)
- [ ] Short descriptive study title (from PI)
- [ ] Study name (from PI)
- [ ] Detailed study abstract (from PI)

## 0. ENA Webin portal

<https://www.ebi.ac.uk/ena/submit/webin/login>

## 1. Register study

<https://ena-docs.readthedocs.io/en/latest/submit/study.html>

Login to the [Webin portal](https://www.ebi.ac.uk/ena/submit/webin). Under
"Studies (Projects)", click on "Register study".

Fill out (need to consult the PI for text!)

 - [ ] Release date (se notes below)
 - [ ] Short descriptive study title
 - [ ] Study name
 - [ ] Detailed study abstract.

You may edit these fields later. See
<https://ena-docs.readthedocs.io/en/latest/update/metadata/interactive.html#updating-studies-samples-experiments-runs-and-analyses-interactively>

Note on Release date: *The study and its associated data will not become public
until the study release date has expired. The default for a newly registered
study is to have a hold date two months after the submission date. The release
date can be as much as 2 years beyond the present date, and on this day the
study and its data will automatically be made public. Notification of this will
be sent in advance to all email addresses registered with your submission
account. You can change the release date at any time to make it sooner or
later, but once the data becomes public you may not make it private again.* See
also: <https://ena-docs.readthedocs.io/en/latest/faq/release.html>

Note on Accessions: *Once a study is registered, Webin will report two
accession numbers for the study. The first starts with PRJEB and is called the
BioProject accession. This is typically used in journal publications. The study
will also be assigned an alternative accession number that starts with ERP.
This accession number is called the study accession.*

## 2. Register samples

- [ ] Get sample sheet from PI! See [metadata](../metadata/README.md).

Then see
<https://ena-docs.readthedocs.io/en/latest/submit/samples.html>,
<https://ena-docs.readthedocs.io/en/latest/submit/samples/interactive.html>

## 3. Upload raw reads

<https://ena-docs.readthedocs.io/en/latest/submit/reads.html>,
<https://networklessons.com/uncategorized/lftp-stuck-making-data-connection>

1. Get an ENA-formatted file with file names and descriptions from user (e.g.,
   [`fastq2_template_1699967766479.tsv`](fastq2_template_1699967766479.tsv)).
   Template file can be downloaded here:
   <https://www.ebi.ac.uk/ena/submit/webin/read-submission> (then choose
   **Download spreadsheet template for Read submission**, **Please select file
   format** (e.g. *Submit paired reads using two Fastq files*), **Please select
   fields** (`sample`, `study`, `instrument_model`, `library_name`,
   `library_source`, `library_selection`, `library_strategy`, `library_layout`,
   `forward_file_name`, `forward_file_md5`, `reverse_file_name`,
   `reverse_file_md5`),


2. Fill out the columns in the template.

TEXT HERE

   Important: For the next step, we assume that the columns `forward_file_md5`
   and `reverse_file_md5` are empty, but that the rest of the columns
   (especially file names) are filled in!  We wish to calculate md5 sums and
   upload the filenames in that file to ENA, and then add those descriptions to
   the file.  After read files are uploaded, the tsv file is uploaded and all
   files are validated (given that samples were successfully registered).

3. Gather files as symlinks into one folder

On nrmdna01.nrm.se:

        $ myfolder='/projects/BIO-projects/johanyla/tmp/submission'
        $ myfile='fastq2_template_1699967766479.tsv'

        $ mkdir -p "$myfolder"
        $ cd "$myfolder"
        $ cp "$myfile" "$myfile".bkp

TEXT HERE



        $ grep -E -v '^FileType|sample' "$myfile" | awk '{print $12"\n"$13}' > files.txt
        $ sed -i 's#/dnadata#/backup#' files.txt # Add correct search/replace depending on the folder structure on nrmdna01.nrm.se
        $ while read -r fil ; do
            ln -s "$fil"
          done < files.txt

4. Calculate MD5 sums

Note: `parallel` is currently, 12 jul 2023, not installed globally on nrmdna01.nrm.se

        $ screen -S md5
        $ cd "$myfolder"
        $ find -L . -maxdepth 1  -name '*.fastq.gz' | parallel 'md5sum {} > {/.}.md5'
        $ sed -i 's#./##' *.md5
        $ cat *.md5 > MD5SUMS

5. Add the correct filenames and md5sums to the tsv file (using, e.g., the
   script [`include_md5sums.pl`](https://github.com/Naturhistoriska/NRM-DNA-lab/blob/main/src/include_md5sums.pl))

        $ ./include_md5sums.pl "$myfile" MD5SUMS > PRJEB64275.tsv

6. Submit to ENA server using lftp mirror

        $ cd /projects/BIO-projects/johanyla/tmp/submission
        $ screen -S ena
        $ mypassword="XXXX"
        $ lftp -e "set ftp:ssl-allow off;" -u Webin-65361,"$mypassword" webin2.ebi.ac.uk
        lftp> mirror -v -p -c -R -P 10 -L --dry-run -f *.fastq.gz
        lftp> mirror -v -p -c -R -P 10 -L -f *.fastq.gz

**Note** IT just recently allowed access with lftp to ENA. The full command is
untested (ons 27 sep 2023 14:39:03).

7. Upload and validate tsv file

Open <https://www.ebi.ac.uk/ena/submit/webin/read-submission>,
click on "Upload filled spreadsheet template for Read submission" and
"Upload filled spreadsheet template for Read submission".
Select `PRJEB64275.tsv`.

### Links

- ENA <https://www.ebi.ac.uk/ena/browser/submit>
- ENA Webin-CLI <https://ena-docs.readthedocs.io/en/latest/submit/general-guide/webin-cli.html>
- Genbank <https://www.ncbi.nlm.nih.gov/genbank/submit_types/>
- INSDC <https://www.insdc.org/>

