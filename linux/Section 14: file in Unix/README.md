# File in Unix

## 1. /proc files (procfs)
```
The /proc directory is present on all Linux systems, regardless of flavor or architecture. The /proc directory is NOT a real file system but a virtual file system that is created dynamically by Linux to provide access to certain types of hardware information and information about the running processes. It is mapped to /proc and mounted at boot time.
```

##### 1.1 To display information about your CPU, you can use the cat /proc/cpuinfo command:
```
cat /proc/cpuinfo
```

##### 1.2 To display information about the file systems supported by currently running Linux kernel, you can use the cat /proc/filesystems command:
```
cat /proc/filesystems
```

##### 1.3 To display statistics about memory usage on the system, use the cat /proc/meminfo command:
```
cat /proc/meminfo
```

##### 1.4 To display the Linux kernel version, distribution number and other kernel-related information, use the cat /proc/version command:
```
cat /proc/version
```

##### 1.5 check system uptime
```
cat /proc/uptime
```

##### 1.6 check running process:
```
Within /proc’s numbered directories, you will find a few files and links. These directories’ numbers correlate to the PID of the command being run within them.

> ps aux

Result:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      3745  0.0  0.2 107988  7200 ?        Ss   09:53   0:00 sshd: deploy [priv]
deploy    3747  0.0  0.2  76656  7792 ?        Ss   09:53   0:01 /lib/systemd/systemd --user
deploy    3748  0.0  0.0 193636  2444 ?        S    09:53   0:00 (sd-pam)
deploy    3822  0.0  0.1 107988  3492 ?        R    09:53   0:00 sshd: deploy@pts/0
deploy    3823  0.0  0.1  23520  5600 pts/0    Ss   09:53   0:00 -bash
root      4713  0.0  0.0      0     0 ?        I    10:20   0:08 [kworker/1:1]
root      9114  0.0  0.0      0     0 ?        I    12:06   0:09 [kworker/2:4]
root     31357  0.0  0.0      0     0 ?        I    16:29   0:00 [kworker/u6:0]
root     31712  0.0  0.0      0     0 ?        R    16:42   0:00 [kworker/u6:2]
root     31758  0.0  0.0      0     0 ?        I    16:44   0:00 [kworker/1:2]
root     31926  0.0  0.0      0     0 ?        I    16:50   0:00 [kworker/u6:1]
deploy   32031  0.0  0.1  40100  3576 pts/0    R+   16:53   0:00 ps -aux

# checking the file necessary for PID=31758

> sudo ls /proc/31758

Result:
attr	    comm	     fd        map_files   net		  pagemap      schedstat     stat     timerslack_ns
autogroup   coredump_filter  fdinfo    maps	   ns		  patch_state  sessionid     statm    uid_map
auxv	    cpuset	     gid_map   mem	   numa_maps	  personality  setgroups     status   wchan
cgroup	    cwd		     io        mountinfo   oom_adj	  projid_map   smaps	     syscall
clear_refs  environ	     limits    mounts	   oom_score	  root	       smaps_rollup  task
cmdline     exe		     loginuid  mountstats  oom_score_adj  sched        stack	     timers

```

## 2. Root folder /:
```
the root directory of the hierarchy
```

## 3. /bin:
```
- contain the essential command binaries required for user
- Nowadays: being merged into /usr/bin (usrmerge)

>  ls /bin/:

Result:
bash                dir            login          ntfstruncate          systemd-hwdb
btrfs               dmesg          loginctl       ntfsusermap           systemd-inhibit
btrfs-debug-tree    dnsdomainname  lowntfs-3g     ntfswipe              systemd-machine-id-setup
btrfs-find-root     domainname     ls             open                  systemd-notify
btrfs-image         dumpkeys       lsblk          openvt                systemd-sysusers
btrfs-map-logical   echo           lsmod          pidof                 systemd-tmpfiles
btrfs-select-super  ed             mkdir          ping                  systemd-tty-ask-password-agent
btrfs-zero-log      efibootdump    mkfs.btrfs     ping4                 tar

```

## 4. /boot:
```
- contains files for the bootloader
```

## 5. /dev:
```
- Contains device file that represent hardware or software devices

- for example: /dev/null, /dev,sda (file sata drive), /dev/tty (terminal device file)
```

## 6. /etc:
```
- contains system-wide configuration file and directories

- these files are generally text file that can be edited for system configuration
```