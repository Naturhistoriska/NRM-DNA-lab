# NRM DNA lab

- Last modified: tis maj 23, 2023  05:10
- Sign: JN

## Standard data flows

![](img/Diagram1.png)

## Personal checklist to get started

- [ ] Account on GitHub (<https://github.com/>)
- [ ] Member of Naturhistoriska organization (<https://github.com/Naturhistoriska>)(ask Dept. head)
- [ ] MobaXterm or (recommended) WSL2 installed on your NRM Windows machine (<https://learn.microsoft.com/en-us/windows/wsl/install>)
- [ ] Accounts on Msl1, Galaxy, Junior (ask JN)
- [ ] Account on nrmdna01.nrm.se (ask IT)
- [ ] Personal account on uppmax (<https://www.uppmax.uu.se/support/getting-started/applying-for-a-user-account/>)
- [ ] Member of projects `p_nrmdnalab_storage` and `p_nrmdnalab` on rackham (uppmax)


---

## Securing meta data from user

Text



## Data download from NGI to NRM backup using DDS

<https://scilifelabdatacentre.github.io/dds_cli/>

- Login to nrmdna01.nrm.se using your NRM credentials
- Change to relevant directory
- Make sure the dds-cli is available
- Start a screen session
- Run the client
- Revisit the server later, reconnect to the screen session
- Check md5 sums

## Create a project directory on rackham

- Make sure you have access to `/proj/nrmdnalab_storage` and that there are still storage space left (check with `uquota`)
- Create a new project folder under `/proj/nrmdnalab_storage/nobackup/`. For example (**Need `ptemplate` <https://gist.github.com/nylander/beff8f66d3b5c30c6c3ec732688e5373>**:
  `ptemplate myproject`


## Data download from NGI to rackham using DDS

<https://scilifelabdatacentre.github.io/dds_cli/>


## Quality Control of Illumina data

- Check data information from NGI
- Run our own data QC (see also below)


## Quality filtering and merging of Illumina data

<https://github.com/nylander/fastp-cleaning>


## Create (symbolic/soft) links to appropriate folder

    $ find $DIR -type f -name '*.fastq.gz' -exec ln -s {} . \;

