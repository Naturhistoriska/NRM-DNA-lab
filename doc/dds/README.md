# Data Download from NGI using DDS

- Last modified: tis nov 21, 2023
- Sign: bodicron


## Background

(Text taken from <https://ngisweden.scilifelab.se/resources/data-delivery-dds/>)

> When a project is ready for delivery, NGI registers a new delivery project with
> DDS.  DDS (Data Delivery System) is a command-line tool developed by the Data
> Centre at SciLifeLab together with NGI. It consists of a command-line-interface
> (CLI) and a web interface. Data uploaded to DDS is securely encrypted at all
> times and can only be decrypted by members of the specific project.

> Initially, the PI of the sequencing or genotyping project will be assigned as
> the PI of the delivery project in DDS. The bioinformatics responsible person
> specified on the order will be added as a member of the delivery project. When
> the delivery project has been created, the PI and any member of the project
> will receive an e-mail from SciLifeLab saying that the project is now available
> for access.  The PI can administer the delivery project and, can therefore, add
> or remove member(s) and set members as project owners through the DDS CLI .
> Members of the delivery project are able to download the data or have the data
> copied to Bianca (for more information about how DDS works for Bianca, please
> see this link.) After delivery with DDS, the PI is solely responsible for
> ensuring the integrity, availability and safekeeping of the sequencing or
> genotyping data and associated files, as well as ensuring that the data is
> handled in accordance with applicable legislation.

**Important:** "Delivery projects are only active for 45 days after data
delivery and will expire thereafter. The PI of the delivery project is
responsible for ensuring that data is retrieved before the delivery expires.
Once the delivery has expired, it is automatically removed from DDS."

**Note:** In order to use dds for downloading you require a user account.  The
procedure to get one is for the PI to list you as a member or bioinformatician
when *data is ordered* (**TODO:** add details).


## Data download from NGI to NRM-backup using DDS

### Steps

1. Login to `nrmdna01.nrm.se` using your NRM credentials (user name, password,
  and one-time authentication code sent to your email address)
2. Change to relevant directory (create one if necessary). Note: the current
  folder structure on the server is
  `/projects/<dept>-projects/<PI-NRM-username>`. The PI may, or may not already
  have an account on the server, and may, or may not know how to create folders
  etc.
3. Make sure the `dds-cli` is available (otherwise install in your `$HOME/bin/`.
  Note: easiest is probably to download the latest binary release for Ubuntu
  20.04 (see link on <https://github.com/ScilifelabDataCentre/dds_cli/releases>
  saying "`dds_cli_ubuntu-20.04_x86_64`", then rename it to `$HOME/bin/dds`,
  and finally `chmod +x $HOME/bin/dds`)
4. Start a screen session (`screen -S name`)
5. Run the client to download data (see [usage](#using-the-dds-client) below).
  Detach from the screen session if needed (`Ctrl+A`, `Ctrl+D`).
6. Revisit the server later, reconnect to the screen session (`screen -R name`)
7. Check md5 sums (<https://github.com/nylander/Check_MD5SUMS>. You most
  probably want to download the script `check_md5sums.sh`, put it in your
  `$HOME/bin`, and make it executable.)
8. Exit the screen session  (`exit`)
9. If you have created a folder for a PI, then the user- and group permissions
  are set to your user. Make sure others have read permissions to all files and
  folders. In addition, it is probably a good idea to also remove write
  permission for files (to avoid deletion). For example:

        $ chmod -R o+r /projects/BIO-projects/piname
        $ find /projects/BIO-projects/piname -type d -exec chmod o+rx {} \;
        $ chmod -R -w /projects/BIO-projects/piname

### Using the dds client

**Note** You need to supply your registered user, password, and one-time-code
(code send by email) when performing the commands below.  See here for account
details: <https://scilifelabdatacentre.github.io/dds_cli/#get-an-account>.

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

Invite other users to a project

    $ dds user add "someone@somewhere.se" -p "ngisthlm00468" -r "Researcher"

### Links

- <https://scilifelabdatacentre.github.io/dds_cli/examples/>
- <https://ngisweden.scilifelab.se/resources/data-delivery-dds/>
- <https://scilifelabdatacentre.github.io/dds_cli/>

## Data download from NGI to rackham

- <https://scilifelabdatacentre.github.io/dds_cli/>

### Steps

1. If the PI have a storage and/or compute account on rackham, make sure to be
   added to the project (apply on <https://supr.naiss.se>). Otherwise, make sure
   you have access to `/proj/nrmdnalab_storage`.
2. Check before you start that there are still storage space left (check with
  `uquota`).
3. Create a new project folder (e.g., under
   `/proj/nrmdnalab_storage/nobackup/`). One way of doing that can be seen in
   this example (using `ptemplate`
   <https://gist.github.com/nylander/beff8f66d3b5c30c6c3ec732688e5373>):
   `ptemplate myproject`
4. Change directory to where the data should be downloaded (e.g. `raw_data`)
5. Load the `dds` program using the rackham module system: `module load
   bioinfo-tools dds-cli`
6. Start the client: `dds`

### Links

- <https://ngisweden.scilifelab.se/resources/data-delivery-dds/>

