# Backup of raw sequence data on NRM

- Last modified: 2025-11-17 10:55:33
- Sign: nylander

## Description

NRM does provide a backup server for raw sequencing data, `nrmdna01.nrm.se`.
This computer is reachable only from within the NRM firewall with the
exceptions for connections with `rackham.uppmax.uu.se`, `dardel.pdc.kth.se`, and
the [DDS data delivery service](https://delivery.scilifelab.se/).

Raw sequencing data can be stored under department-specific folders under
`/projects`. Currently the following structure is available:

    /projects
    ├── BIO-projects/
    ├── BOT-projects/
    ├── PAN-projects/
    └── ZOO-projects/

Under each department folder, each user (same name as the NRM-Windows user) can
create and use their own folder as file area.

## Access

Computer access is made by secure shell (`ssh`), utilizing ssh-keys. Transfer
to and from the server can then be made using, e.g., `rsync`, `scp`, `dds_cli`.

To gain access,

1. Send an e-mail to `NRM-IT` asking "I would like to have access to the NRM DNA
   backup server, Thank you", and provide (in the same e-mail) your public
   ed25519 ssh key (`id_ed25519.pub`).
2. After `NRM-IT` have set up the access, login to `nrmdna01.nrm.se` (using your
   NRM Windows user name) with `ssh`,
3. Create a user folder under the correct department folder. For example, if
   belonging to "ZOO": `mkdir -p /projects/ZOO-projects/$USER`,

## Help

- To get help with `ssh` and "your public ed25519 ssh key", see
  <https://github.com/Naturhistoriska/NRM-DNA-lab/tree/main/doc/ssh>.
- To get help with data transfer (`rsync`, `scp`, `dds_cli`), see
  <https://github.com/Naturhistoriska/NRM-DNA-lab/tree/main/doc/ssh> and
  <https://github.com/Naturhistoriska/NRM-DNA-lab/tree/main/doc/dds>.

## Notes

- Currently, the default umask is set to 022, which ensures *Owner*: Has full
  read, write, and execute permissions for all new files and directories.
  *Group*: Can only read and execute directories, and only read files.
  *Others*: Can only read and execute directories, and only read files.  In
  addition, department-specific groups are also set up, which may override some
  of these permissions mentioned above.
- Empirically we have found that for some file sources, the permissions are
  sometimes overridden, which may make it more difficulties for other users or
  groups to locate files outside of the user's own folders. Some manipulation
  of permissions (by the user/owner) may be in order (using `chmod`, `chown`,
  etc).
- No written policy on data duration or maximum storage size is currently
  available.
