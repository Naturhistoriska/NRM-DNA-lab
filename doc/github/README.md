# git and GitHub

- Last modified: Sept 25 2025
- Sign: nylander

## Description

Make sure to join the Naturhistoriska organization on GitHub:
<https://github.com/Naturhistoriska> Basically, create a personal account on
GitHub, then fill out
[Bestallningsblankett-2017-V2.pdf](Bestallningsblankett-2017-V2.pdf)
(don't forget your GitHub user name) and send to Dept. head. Tell JN when
approved.

Also make sure to be added to the github team `NRM-DNA-lab` within the
Naturhistoriska github organization (ask JN).

You may then create public or private repositories under github.com/Naturhistoriska.

# Setup

## Configure git for first-time usage

Before using command-line git for interacting with code ("push and pull"), you
need to configure your identity.  This applies on all computers you wish to use
for git control.

    $ git config --global user.name "John Doe"
    $ git config --global user.email johndoe@example.com

More more details, see <https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup>.

## Setup SSH-connection with GitHub

In order to seamlessly work with private repositories, it is convenient to
allow authentication between your computer and GitHub using ssh-keys.  The idea
is to create ssh-key pairs on each computer you plan to use when communicating
to your github repository, and to transfer (by cut-and-paste) the public part
to GitHub. See [ssh](../ssh/README.md) on how to generate ssh keys.

Once you have the ssh key pair, visit your personal profile on github.com,
click on your profile icon in the upper-right corner, choose Settings, then
look for "SSH and GPG keys".  On the following page, click the green button
"New SSH key", add a title (e.g., from the computer it was generated), then
paste the public key in the Key window, and finally click on green button "Add
SSH key".

You can test the connection by issuing this command (on your local computer
where you have the private key part):

    $ ssh -T git@github.com
    Hi johan! You've successfully authenticated, but GitHub does not provide shell access.

---

# Create or clone a new repository

## 1. Create a (new) project repository on GitHub.com/Naturhistoriska

Here we will create a new, private, and empty repository for a project on github.

1. Open a web browser
2. Create a new project
(<https://github.com/organizations/Naturhistoriska/repositories/new>)
    - Add a name, preferably with PI name and project name. E.g.
      `johan-n-snake-project`
    - Add a short description
    - Make sure the **Private** checkbox is ticked
    - Click on **Create repository**
3. Add the DNA-lab Team to the repository:
    - On the top panel, click on **Settings**
    - Left panel, click **Access Collaborators and teams**
    - Under Manage access: click on **Add teams**
    - Search for `Naturhistoriska/nrm-dna-lab` and continue
    - Choose a role: **Maintain** (or consider *Write* or *Admin*)
    - Click on **Add Naturhistoriska/nrm-dna-lab to this repository**

## 2. Create a (new) project locally

Here we will create a new project repository on our local computer.  We will
later push the files in this repository to our empty github repository created
above.

1. Create a project file hierarchy by cloning a [project
   template](https://github.com/Naturhistoriska/NRM-ptemplate).

        $ git clone https://github.com/Naturhistoriska/NRM-ptemplate.git johan-n-snake-project
        $ cd johan-n-snake-project
        $ sh bin/init.sh
        $ rm old/init.sh

2. Add the newly created GitHub-repository as "remote"

        $ git remote add origin git@github.com:Naturhistoriska/johan-n-snake-project.git
        $ git branch -M main

2. Edit the `README.md` file and add the relevant description of the project.
3. Use the `Notebook.md` file for running notes on analyses. A
   link to the Notebook can be added in the README.md by using the syntax `[link
   to Notebook.md](Notebook.md)`.
4. Add any other relevant files for the project.
   **Warning: Make sure no files with sensitive or private content are added!**
   Project information not intended for github can be placed in the folder `private/`, which is not under git control.
   Safest is to add files one by one using `git add filename`, but below we add all at once:

        $ git status
        $ git add --all

5. Commit to our changes

        $ git commit -m "first commit"

6. Push our committed changes to our main branch over at GitHub

        $ git push -u origin main

## Cloning an existing project

For cloning a **public** repository (from github.com/Naturhistoriska to local), you can do

    $ git clone https://github.com/Naturhistoriska/public_repo_example.git

If the repository is **private**, you need to set up credentials with SSH-keys. See this
[link](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
for help. After this is done, you can clone using this syntax:

    $ git clone git@github.com:Naturhistoriska/private_repo_example.git
    
**Note:** If you clone a public repository, and wish to be able to push changes directly to it (given that you have write permissions), you need to clone the repo using the second method (`git clone git@github.com:`).


## Cloning a repository for collaborative work

If you need to clone a repository on which several group members need to work, then this is somewhat more involved.
In short, you need to make sure created files and folders have the correct permissions for all group members.
Here is an example on dardel.pdc.kth.se, and common project folder `nrmdnalab_storage`.
To access the common project folder, it is assumed that all users are members of the group `pg_nrmdnalab_storage`
(check the output of the command `groups` to confirm your access):

    $ cd /cfs/klemming/projects/supr/nrmdnalab_storage
    $ git clone --config core.sharedRepository=true git@github.com:Naturhistoriska/private_repo_example.git
    $ chgrp -R pg_nrmdnalab_storage private_repo_example
    $ chmod -R g+wX private_repo_example
    $ find private_repo_example -type d -exec chmod g+s {} +
    
**Note:** In principle, the first `--config` argument to `git clone` should take care of it all.
The other commands will have to be done by the user (owner) of the initiated files and folders.
If one run into problems, those may have to be repeated (JN: largely untested).

---

# Git workflow - Ways of working

## Minimal version

Start every session by checking if you are up to date, and on the correct
branch!

    $ git status
    $ git fetch
    $ git status
    $ git pull   # if needed

Do some work, for example, editing the README.md file.

Then:

    $ git add README.md
    $ git commit -m "Important changes in repo description"
    $ git push

## More robust version

(Given that we are up-to-date on branch `main`), start by creating a "working" branch

    $ git checkout -b feature/mywork

Do some work, for example, editing the README.md file. Then

    $ git add README.md
    $ git commit -m "Important changes in repo description"

Go back to `main`. Then checkout a temp branch. The temp branch will be a copy
of main, and we will test to merge your working branch with the temp (not main,
which may or may not cause trouble if you cannot merge)

    $ git checkout main
    $ git checkout -b temp
    $ git merge feature/mywork

If we managed to merge without troubles (hopefully "Fast-forward"), then we can
go back to the main branch and merge with feature/mywork. End by deleting test
and feature/mywork.

    $ git checkout main
    $ git merge feature/mywork
    $ git push
    $ git branch -d feature/mywork
    $ git branch -D test

## Even more robust version

The ultimate way of collaborating with code and text is for someone else to
review the changes you made to a common branch. The reviewer can then either
accept, reject, or start a discussion about the proposed changes.  Within the
git-world this is called to "create a pull request", and to "review a pull
request". Such a procedure is important on larger projects where a single
change can potentially break a working product.  Read more about it
[here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).

## More reading

- <https://git-scm.com/docs/gittutorial>
- <https://training.github.com/downloads/github-git-cheat-sheet/>
- <https://git-scm.com/doc>

