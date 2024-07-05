# Section 27: SElinux Security-Enhanced linux

## I. `SElinux`: Introduction

### 1. what is `SElinux` ?
```
- SElinux is a security module for the linux kernel
- So far, we only had Discretionary Access Control (DAC)
- SElinux provides Mandatory Access Control (MAC)
- It allows us to enforce access control security policies
- Thereby, it reduces vulnerability to privilege-escalation attacks
```

### 2. Why `SELinux`?
```
- Additional layer of security / access control
- Even if our application is flawed, it can be prevented from causing harm
- It gives us fine-grained control over system resources
- It can even limit the access rights of the root user!
```

### 3.History of `SELinux`
```
- Initially developed by the United States National Security Agency (NSA)
- Made open source for the benefit of the wider community
- Adoption into Linux kernel as of version 2.6
- Included in various major Linux distributions:
    + Fedora, CentOS, Red Hat Enterprise Linux AlmaLinux, Rocky Linux
    + Oracle Linux
    + Scientific Linux
```

## II. `SElinux`: the problem with discretionary access control:

### 1. Problem

If our application only executes code in a ways we thought about:
```
- Everything is okay
- Discretionary access control is enough
```

But we should not expect this to be the case:
```
- There might be bugs in our code
- There might be bugs in libraries that we use
```

Thus, we should assume:
```
- People will be able to break in, and execute arbitrary code on our system
- How can we prevent them even after that?
```

### 2. Example: running a web server

```
- Let's say we're running a webserver (nginx)
- And through an incorrectly placed symlink, an attacker could
suddenly access the whole filesystem
- The attacker could then access all files that the Unix user / group of the webserver has access to:
    - Database configuration (if installed)
    - Configuration of the mailserver (if installed)
    - Cronjob configuration (/etc/crontab)
    - Maybe this even involves more sensitive files, such as confidential data / files on external drives / files of our database,...
```

### 3. Bugs like these happen easily:

**Path or symlink attacks:**
```
- Manipulating files or symbolic links to gain unauthorized
access or escalate privileges
- This is what we had seen before
```

**Privilege escalation attacks:**
```
- A lower privilege user or process trying to gain higher-level
permissions
```

**Buffer overflow attacks:**
```
- When an application writes more data to a buffer than it can handle, potentially allowing arbitrary code execution
```

**Directory traversal attacks:**
```
- Manipulating a web application to access directories that
should be off-limits
```

**Command injection attacks:**
```
- Injecting and executing commands to compromise an
application or system.
```

**Local and remote file inclusion (LFI/RFI):**
```
- Including files from local or remote servers for execution,
often used in web application attacks
- Example:
    - Unsecured upload form on a PHP website
    - User can upload their own .php files - which then can be executed by the webserver
```

## III. Mandatory access control (MAC)
```
- In addition to the rules from the discretionary access control
- ...access is granted based on additional rules and properties
- The idea:
    + MAC rules (policy) is adjusted to our system and its applications
    + it's significantly more fine-grained than discretionary access control

- Example:
    + According to the permissions (discretionary access control) a program could just access /etc/crontab
    + But, with SElinux: We can enforce, that this access is still being denied

```

**Mandatory access control with SELinux**
```
- So, first the DAC access control rules are being applied
- And if those allow access to a resource / file:
- Then, SELinux will apply its mandatory access control
policy to determine if access should be granted
- Thus:
- MAC with SELinux is not exclusive to DAC
- It further restricts DAC and makes our system more secure
```

## IV. SELinux Detail:

### 1. SELinux: Checking the status, enable, disable

**Check `SELinux` status**:
```
# command:
> getenforce

# Result:
- Enforcing: meaning enable
- Permissive: meaning disable
```

**Check `SELinux` detail status**
```
# command:
> sudo sestatus
```

**Enable `SELinux`**
```
# enable
> setenforce 1 || setenforce enforcing
```


**Disable `SELinux`**
```
# Disable
> setenforce 0 || setenforce permissive
```
**`SELinux`: `Permanently` changing status**

folder
```
# SELinux folder: /etc/selinux/config

# configuration:
- SELINUX=enforcing:
    + SELinux should enforce the policy (and log violoations)

- SELINUX=permissive:
    + SELinux should only log policy violations

- SELINUX=disabled:
    + SELinux is disabled
    + We should consider if we really want to do this
```

### 2. File contexts in SELinux

```
- File contexts are a way of labeling files
- This will allow SELinux to enforce its policy and to check if
access to a certain file / resource is allowed
- We will first have a look at how the labeling works
- Then we will explore an example how this labeling protects
us
- And then we will see how we can change the labeling
```

**how to check SELinux labels**
```
# change directory
> cd /

# check SElinux labels
> ls -Z

# result:
lrwxrwxrwx. root    root    system_u:object_r:bin_t:s0       bin -> usr/bin
dr-xr-xr-x. root    root    system_u:object_r:boot_t:s0      boot
drwxr-xr-x. root    root    system_u:object_r:device_t:s0    dev
drwxr-xr-x. root    root    system_u:object_r:etc_t:s0       etc
drwxr-xr-x. root    root    system_u:object_r:home_root_t:s0 home
lrwxrwxrwx. root    root    system_u:object_r:lib_t:s0       lib -> usr/lib
lrwxrwxrwx. root    root    system_u:object_r:lib_t:s0       lib64 -> usr/lib64
drwxr-xr-x. root    root    system_u:object_r:mnt_t:s0       media
drwxr-xr-x. root    root    system_u:object_r:mnt_t:s0       mnt
drwxr-xr-x. root    root    system_u:object_r:usr_t:s0       opt
dr-xr-xr-x. root    root    system_u:object_r:proc_t:s0      proc
dr-xr-x---. root    root    system_u:object_r:admin_home_t:s0 root
drwxr-xr-x. root    root    system_u:object_r:var_run_t:s0   run
lrwxrwxrwx. root    root    system_u:object_r:bin_t:s0       sbin -> usr/sbin
drwxr-xr-x. root    root    system_u:object_r:var_t:s0       srv
dr-xr-xr-x. root    root    system_u:object_r:sysfs_t:s0     sys
drwxrwxrwt. root    root    system_u:object_r:tmp_t:s0       tmp
drwxr-xr-x. root    root    system_u:object_r:usr_t:s0       usr
drwxrwxr-x. vagrant vagrant system_u:object_r:vmblock_t:s0   vagrant
drwxr-xr-x. root    root    system_u:object_r:var_t:s0       var
```

**`SELinux` Syntax**
```
example: unconfined_u:object_r:user_home_t:s0 Desktop

# SELinux syntax
> [SELinux user]:[SELinux role]:[SELinux type]:[SELinux level]

# Here in this case:
-  The SELinux user is: unconfined_u
-  The SELinux role is: object_r
-  The SELinux type is: user_home_t
-  And the SELinux level is: s0

# In SELinux, best-practice is as follows:
-  All SELinux users end with _u, roles end with _r, and types end with _t
-  Based on the Context, SELinux will decide if access should be granted
-  For us, the type will be the most important part of the SELinux context
```

### 3. How does SELinux protect our server:
```
- The type allow the SELinux policy to allow access to just certain parts of the filesystem

# Example:
- A webserver should only be allowed to access httpd_sys_content_t, httpd_config_t, etc_t (and a few others)

- If it tries to access any file with another type - this access is not allowed and thus prevented (if SELinux is enforcing its policy)
```