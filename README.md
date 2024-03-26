# NRM DNA lab - Standard Workflows

- Last modified: tis mar 26, 2024  03:23
- Sign: JN

---

![Standard data flows](img/Diagram1.png)

---

## Personal Checklist

To be able to work smoothly with the workflows, there are a number of accounts
and settings that needs to be in place for each person.  Please go through the
personal checklist ([`doc/checklist/README.md`](doc/checklist/README.md)) and
send feedback on the progress to the other lab members.

## Create a Project Repository on GitHub

To ensure reproducibility, it is important to document all steps of the data management and analysis.
A recommended procedure is to create a repository where all text is under version control.

NRM have an organization on GitHub: [github.com/Naturhistoriska](https://github.com/Naturhistoriska),
and that is an appropriate location to keep repositories.

Procedure (see [`doc/github/README.md`](doc/github/README.md) for details):

1. Create a private repository on github for the project. Name it short but
   kind-of human readable, e.g., `johan-n-snakes`.
2. Add the GitHub Team `NRM-DNA-lab` as collaborators on the repository. If
   practical, add also the PI (this requires that the PI has a github account,
   and that he or she is added to the Naturhistoriska github organization).

## Securing Meta Data from User

Meta data about the samples. This information is crucial in the workflows, and
will be used in the [database submission
step](#10-data-submission-to-public-databases).  Important is to start a
project by providing the user with a sample sheet to be filled in before
starting any lab work.  The same sheet can then be used for ordering data from
NGI, running bioinformatic workflows, and submitting relevant data to public
databases.

Please see the instructions for meta data here:
[doc/metadata/README.md](doc/metadata/README.md).

## Ordering Sequences from SciLifeLab/NGI

Note: current supplier of NGS data are the NGI-platforms in Stockholm and
Uppsala. Both are under SciLifeLab
([https://www.scilifelab.se/units/ngi](https://www.scilifelab.se/units/ngi))
but they differ in how sequences are ordered and delivered, as well in what
machines are available.

See descriptions in [doc/ngi/README.md](doc/ngi/README.md).

## Data Download from NGI to NRM-backup using DDS

See descriptions in [doc/dds/README.md](doc/dds/README.md).

## Data Download from NGI to Rackham using DDS

See descriptions in [doc/dds/README.md](doc/dds/README.md).

## Copy Files Between Computers

See description in [doc/ssh/README.md](doc/ssh/README.md).

## Quality Control of Sequence Data

A standard quality assessment of sequences are often made by the sequence
provider.  Sometimes, however, it may be relevant to do this on your own.

See descriptions in [doc/qc/README.md](doc/qc/README.md).

## Data Cleaning, Merging, etc

Note: this step may or may not be necessary depending on the choice of
downstream analyses.

See description in [doc/cleaning/README.md](doc/cleaning/README.md).

## Analyses

See [doc/analyses/README.md](doc/analyses/README.md) for description.

## Data Submission to Public Databases

Sequence data can be submitted to public databases such as
[Genbank](https://www.ncbi.nlm.nih.gov/genbank/submit/) or
[ENA](https://www.ebi.ac.uk/ena/browser/submit). This is something that the NRM
DNA-lab can assist in doing. A prerequisite for doing this is that the user
submitted a properly filled out sample sheet in the very start of the project
(see [Metadata section](#securing-meta-data-from-user).

Example for submitting short-read (Illumina) data to ENA:
[doc/ena/README.md](doc/ena/README.md).


