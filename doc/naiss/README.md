# Working with remote compute resources

- Last modified: 2025-11-17 10:57:39
- Sign: nylander

## Description

The compute resources we currently use (autumn 2025) is the "dardel"-cluster
belonging to KTH in Stockholm.  To get access to the resource and
start working with NRM-data, you need to have

1. a personal account on SUPR (<https://supr.naiss.se/person/register/>).
2. a shell-account on dardel.pdc.kth.se
   (<https://support.pdc.kth.se/doc/getting_access/get_access/#applying-for-an-account>)
3. a membership in projects `nrmdnalab_storage` and `nrmdnalab` on dardel.
   You can ask for membership by applying through the <https://supr.naiss.se>
   portal (go to Projects, and under Request Membership in Project, search for
   `nrmdnalab` and `nrmdnalab_storage` (or simply ask JN or BC).
4. your public ssh key added to <https://loginportal.pdc.kth.se/>

## Working with the cluster

Login:

    $ ssh yourdardeluser@dardel.pdc.kth.se

When you log in to dardel, you will reside on a *login node*. The login node
are connected to a large number of *compute nodes*.  When you need to run a
process that is CPU- and/or memory demanding, you do that by specifying the
commands in a file, which you then submit to a queue-system (SLURM).  Depending
on availability, your job is then waiting in the queue for a while until it is
send to one or several compute nodes.

On the login nodes node, you will have a standard Linux file structure with a
home directory etc.  You will also be a member of one or several projects, and
they have usually a "project storage" folder (and sometimes also a "project
folder").

To see your project memberships, available disk space, and CPU hours, use the
command `projinfo`.

### The SLURM system

Example of a slurm script: [simple-slurm-script.sh](simple-slurm-script.sh)

Submit the script by:

    $ sbatch simple-slurm-script.sh

The output from the slurm system will be written in the folder where `sbatch`
was issued.

### Links

- Quick start on Dardel: <https://support.pdc.kth.se/doc/basics/quickstart/>
- Documentation and tutorials for Dardel: <https://support.pdc.kth.se/doc/site_map/>
- How to Run Jobs on Dardel: <https://support.pdc.kth.se/doc/run_jobs/job_scheduling/>
- Dardel partitions: <https://support.pdc.kth.se/doc/run_jobs/job_scheduling/#dardel-partitions>
- SLURM submit system documentation: <https://slurm.schedmd.com/documentation.html>
