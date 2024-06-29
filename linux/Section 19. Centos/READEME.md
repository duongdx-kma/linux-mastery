# PACKAGE MANAGER WITH `RPM` AND `DNF` ON CENTOS:

## 1. package manager `rpm`
**concept:**
```
- `.rpm` without package manager:
    (+) .rpm are archives that contain all the files & configuration required to install a software
```

### 1.1 inspect .rpm file
**command:**
```
# we can inspect the .rpm file:
> rpm -qpl [file_name].rpm
```

**example:**
```
# download rpm file:
> wget -O chrony-4.1-3.el9.x86_64.rpm https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages/chrony-4.1-3.el9.x86_64.rpm

# inspect .rpm file:
> rpm -qpl chrony-4.1-3.el9.x86_64.rpm
```

### 1.2 install package from .rpm file:

**command:**
```
> rpm -i [file_name].rpm
```

### 1.3 Query all installed packages: `rpm`

**command:**
```
# Query all installed packages.
> rpm -qa

# query specific package:
> rm -qa | grep [package_name]
```

### 1.4 Remove installed package: `rpm`


**command:**
```
# Remove installed package.

> rpm -e [package_name]
```

## 2. package manager `DNF`

```
sudo dnf config-manager --set-enabled crb
```


### 2.1 `DNF` search for software:
**command:**
```
> dnf search [term]

# for example:

> dnf search link
```

### 2.2 `DNF` install & update software:
```
> sudo dnf install [package-name]

> sudo dnf update

# example:

> sudo dnf install net-tools -y
```


## 3. `DNF` repositories:

```
we can define those repositories in the following files:
- /etc/dnf/dnf.conf
- /etc/yum.repos.d/*.repo
```

## 4. Dependencies:

```
- Can provide certain features:
    > dnf repoquery --provides [package_name]
- ... and also require certain features:
    > dnf repoquery --requires [package_name]

- We can also use this to find packages:
    (+) We can also list which package provides a certain feature:
        > dnf repoquery --whatprovides
    (+) We can also list which package requires a certain feature:
        > dnf repoquery --whatrequires
- We can list the dependencies with the following command:
        > dnf deplist [program]
```

## 5. `DNF` update, upgrade and downgrade:

### 5.1 `DNF` upgrade:
**command**
```
> dnf upgrade [package]
> dnf upgrade [package-with-version]

# upgrade exclude some package
> dnf upgrade --exclude=[package]
> dnf upgrade --exclude=python3,python-unversioned-command,python3-libs,python3-tkinter

```

**example**
```
# step1: check current python version:
> python3 --version

# step1: result
Python 3.9.8

# step2: show available versions:
> dnf list python3 --showduplicates

# step2: result
python3.i686                                                      3.9.18-1.el9                                                     crb
python3.x86_64                                                    3.9.18-1.el9                                                     baseos
python3.i686                                                      3.9.18-2.el9                                                     crb
python3.x86_64                                                    3.9.18-2.el9                                                     baseos
python3.i686                                                      3.9.18-3.el9                                                     crb
python3.x86_64                                                    3.9.18-3.el9                                                     baseos
python3.i686                                                      3.9.19-1.el9                                                     crb
python3.x86_64                                                    3.9.19-1.el9                                                     baseos
python3.i686                                                      3.9.19-2.el9                                                     crb
python3.x86_64                                                    3.9.19-2.el9                                                     baseos  



# step3: upgrade newer version
> sudo dnf upgrade python3-3.9.19-2.el9

# step3: result
Python 3.9.19

```



### 5.2 `DNF` downgrade:
```
# downgrade:

> dnf downgrade [package]
> dnf downgrade [package-with-version]
```

**example:**
```
> dnf downgrade python3

or

> dnf list python3 --showduplicates

# result:
python3.i686                                                      3.9.18-1.el9                                                     crb
python3.x86_64                                                    3.9.18-1.el9                                                     baseos
python3.i686                                                      3.9.18-2.el9                                                     crb
python3.x86_64                                                    3.9.18-2.el9                                                     baseos
python3.i686                                                      3.9.18-3.el9                                                     crb
python3.x86_64                                                    3.9.18-3.el9                                                     baseos
python3.i686                                                      3.9.19-1.el9                                                     crb
python3.x86_64                                                    3.9.19-1.el9                                                     baseos
python3.i686                                                      3.9.19-2.el9                                                     crb
python3.x86_64                                                    3.9.19-2.el9                                                     baseos  

> dnf downgrade python3-3.9.18-3.el9

```


## 6. Automatic update:

```
- sudo dnf install dnf-automatic

- sudo nano /etc/dnf/automatic.conf

- sudo systemctl enable --now dnf-automatic.timer
```


## 7: Epel-release: Extra Packages for Enterprise Linux

```
sudo dnf install epel-release
```