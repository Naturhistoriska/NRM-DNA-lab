# NRM DNA lab

- Last modified: fre maj 26, 2023  12:17
- Sign: JN

---

## Personal checklist to get started

- [ ] Account on GitHub (<https://github.com/>)
- [ ] Member of Naturhistoriska organization (<https://github.com/Naturhistoriska>) (Send [Bestallningsblankett-2017-V2.pdf](doc/Bestallningsblankett-2017-V2.pdf) to Dept. head)
- [ ] MobaXterm or (recommended) WSL2 installed on your NRM Windows machine (<https://learn.microsoft.com/en-us/windows/wsl/install>)
- [ ] Accounts on Msl1, Galaxy, Junior (ask JN)
- [ ] Account on nrmdna01.nrm.se (ask NRM IT)
- [ ] Functioning (NRM) VPN client if working remotely (consult NRM IT)
- [ ] Personal account on uppmax (<https://www.uppmax.uu.se/support/getting-started/applying-for-a-user-account/>)
- [ ] Member of projects `p_nrmdnalab_storage` and `p_nrmdnalab` on rackham (uppmax)

---

## Standard data flows

![](img/Diagram1.png)

### 1. Securing meta data from user

Meta data about the samples. This information in crucial in the workflows, and will be used in the submission step.

- Text 1
- Text 2

### 2. Ordering sequences from SciLifeLab/NGI

<https://ngisweden.scilifelab.se/>

- Text 1
- Text 2

### 3. Data download from NGI to NRM backup using DDS

<https://scilifelabdatacentre.github.io/dds_cli/>

- Login to `nrmdna01.nrm.se` using your NRM credentials
- Change to relevant directory (create one if necessary)
- Make sure the `dds-cli` is available (otherwise install in your `$HOME/bin/`)
- Start a screen session (`screen -S name`)
- Run the client to download data. Detach from the screen session if needed
  (`Ctrl+A`, `Ctrl+D`)
- Revisit the server later, reconnect to the screen session (`screen -R name`)
- Check md5 sums (<https://github.com/nylander/Check_MD5SUMS>)
- Exit the screen session  (`exit`)

### 4. Data download from NGI to rackham

<https://scilifelabdatacentre.github.io/dds_cli/>

- Make sure you have access to `/proj/nrmdnalab_storage` and that there are
  still storage space left (check with `uquota`)
- Create a new project folder under `/proj/nrmdnalab_storage/nobackup/`. For
  example (**Need `ptemplate`**
  <https://gist.github.com/nylander/beff8f66d3b5c30c6c3ec732688e5373>:
  `ptemplate myproject`
- Text

### 5. Quality Control of Illumina data

- Check data QC information from NGI
- Run our own data QC (see also below)
- Text

### 6. Data cleaning, merging, etc

Note: this step may or may not be necessary depending on the choice of
downstream analyses. See, e.g., "Analyses (e.g., mapping)"

<https://github.com/nylander/fastp-cleaning>

- Text 1
- Text 2

After the cleaning, we can create links to the cleaned data (instead of copying) each time we need to re-use them for a task.
At this stage (if we have made md5sum-verified backups), we can also delete the raw data.

Create (symbolic/soft) links from the folder in `$DIR` to the current working directory:

        $ find "$DIR" -type f -name '*.fastq.gz' -exec ln -s {} . \;


### 7. Analyses

#### 8. Short-read mapping to reference

We have used, to some success, the nf-co.re/eager
(<https://github.com/nf-core/eager>)  pipeline for this task. It was tailored
for low-quality or ancient DNA, but can be used for fresh material (Illumina
fastq) as well.  The workflow includes a cleaning and filtering step, so raw
data can be used as input.

- Prepare a sample sheat ([example](doc/eager-data.tsv))
- Visit <https://nf-co.re/eager>
- Text 1
- Text 2


### 8. Copy files from rackham to NRM computers

The best strategy is to log in to a NRM computer, and then "drag" the files from rackham. The preferred tools are either `rsync` or `scp`.

#### scp

Example when logged in to `msl1.nrm.se`: transfer one file from rackham to current working directory.

    [msl1]$ scp usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/metadata.txt .

#### rsync

Example when logged in to `msl1.nrm.se`: transfer one directory (with all
content, recursively) from rackham to current working directory.

    [msl1]$ rsync -avh usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/my_folder .

**Note** The command above will transfer any content of `my_folder` from
rackham to msl1. If the folder doesn't already exist on msl1, it will be
created.  A subtle change in behaviour can be made (see traling `/` on the
source directory in the example below), in order for all files in `my_folder`
to be transferred, but not the folder itself!

    [msl1]$ rsync -avh usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/my_folder/ .

The second syntax is commonly used when, say, you already have `my_folder` in
both locations, but you want to transfer all files added in the rackham copy to
msl1. Again, and example:

    [msl1]$ rsync -avh usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/my_folder/ my_folder
