# Working with remote compute resources

- Last modified: tis apr 30, 2024  10:56
- Sign: nylander

**Note**: The resources below (rackham) will be [decommissioned during
2024](https://www.uppmax.uu.se/uppmax-news/?tarContentId=1069594).  The general
procedures for the next system (most probably ["Dardel and Klemming"]()) will
be similar as for rackham, but the instructions below needs to be updated.

## Description

The compute resources we currently use (autumn 2023) is the "rackham"-cluster
belonging to the Uppmax-project in Uppsala.  To get access to the resource and
start working with NRM-data, you need
1. a personal account on uppmax
   (<https://www.uppmax.uu.se/support/getting-started/applying-for-a-user-account/>).
2. to be a member of projects `nrmdnalab_storage` and `nrmdnalab` on rackham.
   You can ask for membership by applying through the <https://supr.naiss.se>
   portal (go to Projects, and under Request Membership in Project, search for
   `nrmdnalab` and `nrmdnalab_storage`.  (ask JN or BC)

## Working with the cluster

Login:

    $ ssh user@rackham.uppmax.uu.se

When you log in to rackham, you will reside on one of a handful of *login
nodes*. The login nodes are connected to a large number of *compute nodes*.
When you need to run a process that is CPU- and/or memory demanding, you do
that by specifying the commands in a file, which you then submit to a
queue-system (SLURM).  Depending on availability, your job is then waiting in
the queue for a while until it is send to one or several compute nodes.

On the login nodes nodes, you will have a standard Linux file structure with a
home directory etc.  You will also be a member of one or several projects, and
they have usually a project folder, and a "project storage" folder.  At
NRM-DNA-lab, we currently have one common project, `snic2022-22-1156`, or
"nrmdnalab".  The path to the project folder is then `/proj/nrmdnalab`, and the
path to the storage folder is `/proj/nrmdnalab_storage`.

To see the available disk storage and CPU hours, use the commands `uquota` and
`projinfo`.

### The SLURM system

Example of a slurm script: [simple-slurm-script.sh](simple-slurm-script.sh)

Submit the script by:

    $ sbatch simple-slurm-script.sh

The output from the slurm system will be written in the folder where `sbatch` was issued.


### Links

- Practicing working on uppmax resources: <https://uppsala.instructure.com/courses/67267>.
- Rackham user guide: <https://www.uppmax.uu.se/support/user-guides/rackham-user-guide/>
- Slurm user guide: <https://www.uppmax.uu.se/support/user-guides/slurm-user-guide/>

