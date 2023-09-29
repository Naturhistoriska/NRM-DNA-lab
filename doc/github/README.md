# Github

- Last modified: fre sep 29, 2023  01:40
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

## Steps to create a new git repository

Easiest is to visit <https://github.com/Naturhistoriska>, and click on green
button "New".  Make sure the Owner is Naturhistoriska, and supply a meaningful
repository name. For example: `johan-n-snake-project`. Add a more detailed
Description (still short). Choose Public or Private.  Private is probably
appropriate for an ongoing research project. The down-side is that there might
be limits on if and how the repository can be shared with a collaborator/PI.
Then click on green button "Create repository".

After creating the empty repository on GitHub, do (either):

### Create a new repository on the command line

    $ echo "# johan-n-snake-project" >> README.md
    $ git init
    $ git add README.md
    $ git commit -m "first commit"
    $ git branch -M main
    $ git remote add origin git@github.com:Naturhistoriska/johan-n-snake-project.git
    $ git push -u origin main

### or push an existing repository from the command line

    $ git remote add origin git@github.com:Naturhistoriska/johan-n-snake-project.git
    $ git branch -M main
    $ git push -u origin main

## Git workflow

### Minimal version

Start every session by checking if you are up to date

    $ git status
    $ git fetch
    $ git status
    $ git pull # if needed

Do some work, for example, editing the README.md file.

Then:

    $ git add README.md
    $ git commit -m "Important changes in repo description"
    $ git push

### More robust version

(Given that we are up-to-date on branch `main`), create a "working" branch

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

If we managed to merge withut troubles (hopefully "Fast-forward"), then we can
go back to the main branch and merge with feature/mywork. End by deleting test
and feature/mywork.

    $ git checkout main
    $ git merge feature/mywork
    $ git push
    $ git branch -d feature/mywork
    $ git branch -D test

### Even more robust version

The ultimate way of collaborating with code and text is for someone else to
review the changes you made to a common branch. The reviewer can then either
accept, reject, or start a discussion about the proposed changes.  Within the
git-world this is called to "create a pull request", and to "review a pull
request". Such a procedure is important on larger projects where a single
change can potentially break a working product.  Read more about it
[here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).
