# Section 18. Package management with APT & dpkg `Ubuntu`

### 1. dpkg: Debian Package Manager

**concept:**
```
► On the lowest level, dpkg is responsible for installing software
packages
► Those packages are distributed as .deb files, and we can install
them through dpkg:
► dpkg -i package.deb
► A .deb file is a compressed archive (ar file format) with all the
files needed for the program, and its installation on the system
```

**command:**
```
# install package:
> dpkg -i package.deb

# uninstall package:
> dpkg -r package.deb
```

### 2. Dependency management: apt/apt-get

**Statement of problem:**
```
- dpkg was able to install .deb packages on our system
- But we were not able to install dependencies through it
- Thus, we need another tool, that builds on top of dpkg. We can choose one of the following:
        - apt-get:
        - Stable API, we should use this when we're writing scripts
        - apt: API and parameters might change when deemed necessary
```

**concept**
```
- apt-get / apt needs to know which packages are available, and where it can download them from
- We thus need to connect to central repositories,which provide our packages

- Repositories:
    + Repositories from the system:  /etc/apt/sources.list

    + Additional (third party) repositories: /etc/apt/sources.list.d/*
```

**command**
```
# install:
> sudo apt install [package-name]

# install without recommend packages:
> sudo apt install --no-install-recommends [package-name]

# remove:
> sudo apt remove [package-name]

# show packages:
> sudo apt show [package name]
```


### 3. Manage linux system update and upgrade APT: Best practices
```
- We want to keep our system up to date
- We thus want to install available updates on our system:
   - sudo apt upgrade
   - sudo apt-get upgrade --with-new-pkgs
```

```
If we want to have a bigger upgrade, we need to allow apt to
uninstall packages as well:
- sudo apt full-upgrade
- sudo apt-get dist-upgrade

Example for this:
    - Package A depends on Package B (v1.0)
    - Package A is updated, now depending on Package C(v1.0), which conflicts with Package B (v1.0)
    - Package B is uninstalled during dist-upgrade.
```

### 4. Auto remove old dependencies:
```
> sudo apt autoremove
> sudo apt-get autoremove
```

### 5. How does the sources.list work?:
```
The system reads the following file(s) for its repositories:
- /etc/apt/sources.list
- /etc/apt/sources.list.d/*
```
**Source.list syntax**
```
for example: deb http://ports.ubuntu.com/ubuntu-ports/ jammy main restricted

structure: <type> <uri> <distribution> <domain1> <domain2> ...

# Explanation:
- <type>:
    (+) deb: This repository contains binary packages
    (+) deb-src: This repository contains source packages
- <uri>: The address of the repository

- <distribution>: The ubuntu version, we want to download the packages for: jammy, bionic ...
```

| 'domain' | Free software  | Non-free software |
| ------- | --- | --- |
| Officially supported by Canonical | main | restricted |
| Community or supported/Third party | universe | multiverse |

### 5. custom with sources.list.d/:

```
We can add additional repositories to our apt sources
If we were to do this manual:
    (+) We create a new file in /etc/apt/sources.list.d

    (+) Usually: We need to add the GPG key to our system for this repository

    (+) This is needed so that our system trusts the third-party repository

    (+) Usually wherever you find an installation guide for this, they will explain all the steps required
Important:
    (+) The third-party repository could install any software on our system

    (+) It could for example say: I got bash in version 100000 - and our system would trust this and update it
    - Even if bash was installed from the official repository before
```


### 6. Third party packages: ppa

**concept**
```
Personal Package Archive:
- This will usually work only on Ubuntu, not on Debian systems
- It's a website where users can easily provide repositories for others: https://launchpad.net/ubuntu/+ppas
```

**command**

```
# install:
> sudo add-apt-repository ppa:ondrej/php
> sudo apt update


# remove:
sudo add-apt-repository --remove ppa:ondrej/php
```

### 7. Dependency management:

##### 7.1 step1: show dependencies to debug [BASH]:

**step1 command:**
```
> sudo apt show [package-name]
or
> sudo apt-cache show [package-name]
```

**step1: example**
```
> sudo apt show bash
or
> sudo apt-cache show batch
```

**step1: result: check `Pre-Depends`, `Depends` and `Recommends`**
```
Package: bash
Version: 4.4.18-2ubuntu1.3
Priority: required
Essential: yes
Section: shells
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Matthias Klose <doko@debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 1626 kB
Pre-Depends: libc6 (>= 2.15), libtinfo5 (>= 6)
Depends: base-files (>= 2.1.12), debianutils (>= 2.15)
Recommends: bash-completion (>= 20060301-0)
Suggests: bash-doc
Conflicts: bash-completion (<< 20060301-0)
Replaces: bash-completion (<< 20060301-0), bash-doc (<= 2.05-1)
Homepage: http://tiswww.case.edu/php/chet/bash/bashtop.html
Task: minimal
Supported: 5y
Download-Size: 615 kB
APT-Manual-Installed: yes
APT-Sources: http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages
Description: GNU Bourne Again SHell
 Bash is an sh-compatible command language interpreter that executes
 commands read from the standard input or from a file.  Bash also
 incorporates useful features from the Korn and C shells (ksh and csh).

```

##### 7.2 step2: show dependencies to debug [ZSH]:


**step2: `ZSH` command**
```
> sudo apt show zsh
or
> sudo apt-cache show zsh
```

**step2:  `ZSH` result: check `Pre-Depends`, `Depends` and `Recommends`**
```
Package: zsh
Architecture: amd64
Version: 5.4.2-3ubuntu3.2
Priority: optional
Section: shells
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian Zsh Maintainers <pkg-zsh-devel@lists.alioth.debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 2070
Depends: zsh-common (= 5.4.2-3ubuntu3.2), libc6 (>= 2.15), libcap2 (>= 1:2.10), libtinfo5 (>= 6)
Recommends: libc6 (>= 2.23), libncursesw5 (>= 6), libpcre3
Suggests: zsh-doc
Filename: pool/main/z/zsh/zsh_5.4.2-3ubuntu3.2_amd64.deb
Size: 690740
MD5sum: b058e3d8dc2b07af0793e16cb46a35bc
SHA1: 8ff04165dafc5853b00640fedf821143927cc6b6
SHA256: 0ee21e5f87135fcbf5668f8d95f4099bf0d68daf59adc12fc068ce5ec547a6cf
SHA512: dff5c877bf4c3e55f3aec7a05099ce022b6dd3fe603b6ba7d2b64a28d3ff06906f755efa591dc28eaad846b2c6e2a25d52ba3f4892029eda285040501e73c9c3
Homepage: https://www.zsh.org/
Description-en: shell with lots of features
 Zsh is a UNIX command interpreter (shell) usable as an
 interactive login shell and as a shell script command
 processor. Of the standard shells, zsh most closely resembles
 ksh but includes many enhancements. Zsh has command-line editing,
 built-in spelling correction, programmable command completion,
 shell functions (with autoloading), a history mechanism, and a
 host of other features.
Description-md5: a129d6b2d23d2d5d3a6b822d3f8f856d
Supported: 5y

Package: zsh
Architecture: amd64
Version: 5.4.2-3ubuntu3
Priority: optional
Section: shells
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian Zsh Maintainers <pkg-zsh-devel@lists.alioth.debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 2070
Depends: zsh-common (= 5.4.2-3ubuntu3), libc6 (>= 2.15), libcap2 (>= 1:2.10), libtinfo5 (>= 6)
Recommends: libc6 (>= 2.23), libncursesw5 (>= 6), libpcre3
Suggests: zsh-doc
Filename: pool/main/z/zsh/zsh_5.4.2-3ubuntu3_amd64.deb
Size: 689432
MD5sum: 88cf343c589bcd196dc99ea27053bef2
SHA1: 91a64b4219e1090c41d98e79783595dfff76db56
SHA256: b0b29a8baee48f691e4891231262ae49f1e4a78d7bbaba383730416cc8de9b9b
Homepage: https://www.zsh.org/
Description-en: shell with lots of features
 Zsh is a UNIX command interpreter (shell) usable as an
 interactive login shell and as a shell script command
 processor. Of the standard shells, zsh most closely resembles
 ksh but includes many enhancements. Zsh has command-line editing,
 built-in spelling correction, programmable command completion,
 shell functions (with autoloading), a history mechanism, and a
 host of other features.
Description-md5: a129d6b2d23d2d5d3a6b822d3f8f856d
Supported: 5y
```

##### 7.3 for example conflict between [Bash] and [ZSH]:
```
bash: Wants libc6 <= 2.35
zsh: Wants libc6 >= 2.36
```

**command**
```
# command
> sudo apt install -f / sudo apt-get install -f

# explanation:
-f stands for "--fix-broken"

# We run an update / upgrade of our system:
> sudo apt full-upgrade / sudo apt-get dist-upgrade

# If this doesn't work:
> sudo apt autoremove / sudo apt-get autoremove
```


### 8. Verifying installation: debsums
**command**
```
debsums [package / .deb file]

# install:
> sudo apt install debsums

# important parameters:
> -a: list all file (including configuration file)
> -l: list package, that don't have a list of files with their md5 sum
> -s: Silent: only list error file
```

**example**
```
# command
> debsums -a
...
/usr/bin/traceroute6.iputils                                                  OK
/usr/share/doc/iputils-tracepath/NEWS.Debian.gz                               OK
/usr/share/doc/iputils-tracepath/RELNOTES.gz                                  OK
/usr/share/doc/iputils-tracepath/changelog.Debian.gz                          OK
/usr/share/doc/iputils-tracepath/copyright                                    OK
/usr/share/man/man8/tracepath.8.gz                                            OK
...

> debsums php php-fpm

# result:
/usr/share/doc/php/changelog.gz              OK
/usr/share/doc/php/copyright                 OK
/usr/share/doc/php-fpm/changelog.gz          OK
/usr/share/doc/php-fpm copyright             OK
```