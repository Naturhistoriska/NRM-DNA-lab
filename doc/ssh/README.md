# SSH and SCP

- Last modified: 2025-11-17 10:52:12
- Sign: JN

## SSH

Secure shell (SSH) is essential for user computer communication and need to be
in place.  In short: ssh communicates with key pairs (two files). One is
private (should never leave the computer), and one is public (should be
transferred to the computer we wish to communicate with).  If the ssh
applications sees the two files in a communication attempt, the connection is
granted.

### Generate a local pair of key files (Linux, macos)

Default location where key files are located are usually in the folder
`$HOME/.ssh/`.

To generate (interactively):

    $ ssh-keygen -t ed25519

This will interactively ask questions. Accept defaults and leave the passphrase
empty for now.

The result are two files, `id_ed25519` and `id_ed25519.pub`. They are both text
files and can be opened with a text editor.

### Generate a local key pair on Windows

**Note:** I (JN) no longer promote users using MobaXterm for communicating with
other unix computers. Main reason being having problems setting up ssh-keys
(and that you gain so much more using wls2 instead).

Open Ubuntu (via WLS2), and follow the instructions for Linux above.

### Set up passwordless ssh communication

If you want to connect to a remote computer with ssh, and without having to
manually type your password, you can utilize the ssh key pair.  Simply add
content of the public key, `id_ed25519.pub`, to the file
`$HOME/.ssh/authorized_keys` on the server you wish to connect to.  This can be
done manually using cut-and-paste, or, for example, with this command (issued
on your local computer where we have the generated key pair):

    $ ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote.computer.com

Alternatively, this command can be used

    $ cat ~/.ssh/id_ed25519.pub | ssh user@remote.computer.com 'cat >> .ssh/authorized_keys'

**Note**: These procedures for manually adding authorized keys can not be done
on all systems.  One noticeble example is the dardel.pdc.kth.se resource. Here
you instead need to add your key to a "waiting room", by adding the public part
of your key to a a webpage (<https://loginportal.pdc.kth.se/>). In summary,
visit the login portal, authenticate your self on SUPR (click on link, then
click on "Prove My Identity to PDC"), then "Add new key", copy-paste the
content of your .pub into "SSH public key", add a "Key name" (I use the name of
my computer), then use the scroll-down field for "Address - where the key can
be used from" and select the most general form (e.g. `*.nrm.se`).  If you plan
to use the same key (i.e. same computer) form other places, you can add more
addresses here later.

### Access to nrmdna01.nrm.se

Access is only allowed after e-mailing your public key to support@nrm.se.
`NRM-IT` will then create your user account and manually add the key to
`$HOME/.ssh/authorized_keys`.

Once you have access with one computer (one public ed25519 key), you can add
more keys to the file `$HOME/.ssh/authorized_keys`.

---

## SCP and RSYNC

Secure copy, or `scp` is used for transferring files between computers while
keeping the authentications secure (using the same protocols as `ssh`).

Another (secure) way of transferring data, especially file-hierarchies, is to
use `rsync`.

Examples of their usage are given below.

### Copy files from dardel.pdc.kth.se to NRM computers

The best strategy is to log in to a NRM computer, and then "drag" the files
from dardel. The preferred tools are either `rsync` or `scp`.  In order for
`scp` to work smoothly, passwordless `ssh` should be set up between the
computers (see [above](#set-up-passwordless-ssh-communication)).

See also full documentation for dardel file transfers here:
<https://support.pdc.kth.se/doc/data_management/file_transfer/>.

#### scp

Example when logged in to `msl1.nrm.se`: transfer one file from dardel to
current working directory.

    [msl1]$ scp usernameondardel@dardel.pdc.kth.se:/cfs/klemming/projects/supr/nrmdnalab_storage/example.txt .

#### rsync

Example when logged in to `msl1.nrm.se`: transfer one directory (with all
content, recursively) from dardel to current working directory.

    [msl1]$ rsync -avh usernameondardel@dardel.pdc.kth.se:/cfs/klemming/projects/supr/nrmdnalab_storage/my_folder .

**Note** The command above will transfer any content of folder `my_folder` from
dardel to msl1. If the folder doesn't already exist on msl1, it will be
created.  A subtle change in behaviour can be made (see trailing `/` on the
source directory in the example below), in order for all files in `my_folder`
to be transferred, but not the folder itself!

    [msl1]$ rsync -avh usernameondardel@dardel.pdc.kth.se:/cfs/klemming/projects/supr/nrmdnalab_storage/my_folder/ .

The second syntax is commonly used when, say, you already have `my_folder` in
both locations, but you want to transfer all files added in the dardel copy to
msl1:

    [msl1]$ rsync -avh usernameondardel@dardel.pdc.kth.se:/cfs/klemming/projects/supr/nrmdnalab_storage/my_folder/ my_folder

### Copy files to dardel.pdc.kth.se

You can transfer individual files using the `scp` command. However, if you need
to do larger file transfers, you need to use a particular file-transfer server,
and use a particular `rsync` syntax.  See the Notes on
<https://support.pdc.kth.se/doc/data_management/file_transfer/> for full
description.

One example for transferring a folder from msl1 to dardel (pay attention to the
use of `-r` instead of `-a`, and `dardel-ftn.pdc.kth.se` instead of
`dardel.pdc.kth.se`!):

    [msl1]$ rsync -rvh my_folder usernameondardel@dardel-ftn.pdc.kth.se:/cfs/klemming/projects/supr/nrmdnalab_storage/.
