# SSH and SCP

- Last modified: ons sep 27, 2023  05:16
- Sign: JN

## SSH

Secure shell (SSH) is essential for user computer communication and need to be
in place.  In short: ssh communicates with key pairs (two files). One is
private (should never leave the computer), and one is public (should be
transferred to the computer we wish to communicate with).  If the ssh
applications sees the two files in a communication attempt, the connection is
granted.

### Generate a local pair of key files (Linux, macos)

Default location where key files are located are usually in the folder `$HOME/.ssh/`.

To generate (interactively):

    $ ssh-keygen -t ed25519

This will interactively ask questions. Accept defaults and leave the passphrase
empty for now.

The result are two files, `id_ed25519` and `id_ed25519.pub`. They are both text
files and can be opened with a text editor.

#### Generate a local key pair using MobaXTerm on Windows

Note: If you have the option of using ubuntu in WSL2, use that instead of
MobaXTerm!  The key-generation and usage is non-trivial with MobaXTerm.

Note: before generating the SSH key, set a permanent home directory in
MobaXTerm where to store the SSH key and other settings. This way they will be
available after closing MobaXterm: Settings -> Configuration -> General.

- <https://vlaams-supercomputing-centrum-vscdocumentation.readthedocs-hosted.com/en/latest/access/generating_keys_with_mobaxterm.html>
- <https://stackoverflow.com/questions/70680445/why-does-ssh-add-fail-on-mobaxterm-is-it-a-permissions-issue>

(select "ed25519")

The generated key pair is located in XXX.

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

### Access to nrmdna01.nrm.se

Access is only allowed after e-mailing your public key to support@nrm.se. IT
will then create your user account and manually add the key to
`$HOME/.ssh/authorized_keys`.

Once you have access with one computer (one public ed25519 key), you can add
more keys to the file `$HOME/.ssh/authorized_keys`.

---

## SCP (and rsync)

Secure copy, or `scp` is used for transferring files between computers while
keeping the authentications secure (using the same protocols as ssh).

Another (secure) way of transferring data, especially file-hierarchies, is to use rsync.

Examples of their usage are given below.

### Copy files from rackham to NRM computers

The best strategy is to log in to a NRM computer, and then "drag" the files
from rackham. The preferred tools are either `rsync` or `scp`.  In order for
scp to work smoothly, passwordless ssh should be set up between the computers.

#### scp

Example when logged in to `msl1.nrm.se`: transfer one file from rackham to
current working directory.

    [msl1]$ scp usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/metadata.txt .

#### rsync

Example when logged in to `msl1.nrm.se`: transfer one directory (with all
content, recursively) from rackham to current working directory.

    [msl1]$ rsync -avh usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/my_folder .

**Note** The command above will transfer any content of `my_folder` from
rackham to msl1. If the folder doesn't already exist on msl1, it will be
created.  A subtle change in behaviour can be made (see trailing `/` on the
source directory in the example below), in order for all files in `my_folder`
to be transferred, but not the folder itself!

    [msl1]$ rsync -avh usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/my_folder/ .

The second syntax is commonly used when, say, you already have `my_folder` in
both locations, but you want to transfer all files added in the rackham copy to
msl1. Again, and example:

    [msl1]$ rsync -avh usernameonrackham@rackham.uppmax.uu.se:/proj/nrmdnalab_storage/nobackup/my_folder/ my_folder


