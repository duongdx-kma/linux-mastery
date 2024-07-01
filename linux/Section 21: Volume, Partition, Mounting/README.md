# Section 21: Volume, Partition, Mounting

## I. Understand Kib vs KB, MiB vs MB, GiB vs GB

```
Those 2 measurements are in different units!
- 8 Bit = 1 Byte
- 1 Kibibyte (KiB) = 1024 Byte (210 Byte)
- 1 Kilobyte (KB) = 1000 Byte (103 Byte)
```
| Binary | Decimal | Difference |
| --- | --- | --- |
| 1024 bytes KiB (kibibyte) | 1000 bytes kB (kilobyte) | 2.4%|
| 10242 bytes MiB (mebibyte) | 10002 bytes MB (megabyte) | 4.9%| 
| 10243 bytes GiB (gibibyte) | 10003 bytes GB (gigabyte) | 7.4%| 
| 10244 bytes TiB (tebibyte) | 10004 bytes TB (terabyte) | 10.0%| 
| 10245 bytes PiB (pebibyte) | 10005 bytes PB (petabyte) | 12.6%|


## II. Filesystem:

### 1. introduction
```
Each partition usually uses a filesystem to store data

A filesystem is responsible for:
- Data organization: storing files in folder and files

- Space allocation: managing free and used space, releasing space when 
files are deleted

- Metadata management: Storing permissions, ownership, timestamps (file created at, last updated at...)

- Data integrity:
    + Implementing mechanisms for error detection
    + making sure the filesystem is always in a consistent state (preferable even after an unpredicted power loss)
```

### 2. Most common filesystem (Linux filesystem)
```
[ext3]: Third extended FS developed
- Older but still common and in use

[ext4]: Fourth version of the extended filesystem
- Improved performance
- Support for larger disks
- Journaling improvements: Improved recovery after shutdown

[xfs]:
- Especially proficient at managing large files and filesystems
- Optimized for parallel I/O
- Snapshot support, files can share the same data blocks

[btrfs]:
- Support to easily create snapshots
- Enhanced RAID support
```

### 3. Most common filesystem `Window`/`MacOS`
**a. Windows:**
```
- FAT32: Older file system, usually can only store files up to 4GB
- NTFS: Proprietary, sometimes only readable from Linux
- ReFS: Successor of NTFS
- exFAT: Proprietary until 2019, specification published now. Ideal for external drives
```

**b.macOS: APFS**
```
- Filesystem for iOS and macOS devices
- Supports full disk encryption
```

### 4. list up filesystem `command`:
```
> sudo lsblk -l

> sudo lsblk --output NAME,FSTYPE,LABEL,UUID,MODE

> lsblk --help

 NAME  device name
       KNAME  internal kernel device name
     MAJ:MIN  major:minor device number
      FSTYPE  filesystem type
  MOUNTPOINT  where the device is mounted
       LABEL  filesystem LABEL
        UUID  filesystem UUID
          RO  read-only device
          RM  removable device
       MODEL  device identifier
        SIZE  size of the device
       STATE  state of the device
       OWNER  user name
       GROUP  group name
        MODE  device node permissions
   ALIGNMENT  alignment offset
      MIN-IO  minimum I/O size
      OPT-IO  optimal I/O size
     PHY-SEC  physical sector size
     LOG-SEC  logical sector size
        ROTA  rotational device
       SCHED  I/O scheduler name
     RQ-SIZE  request queue size
        TYPE  device type
    DISC-ALN  discard alignment offset
   DISC-GRAN  discard granularity
    DISC-MAX  discard max bytes
   DISC-ZERO  discard zeroes data
```

### 5. Create new `filesystem` and mounting to directory :

**step1: check available space**

list up blocks
```
> sudo lsblk --output NAME,FSTYPE,LABEL,UUID,MODE
```

result:
```
NAME   FSTYPE  LABEL           UUID                                 MODE
sda                                                                 brw-rw----
└─sda1 ext4    cloudimg-rootfs f685bb41-0e3b-40c4-89c1-eea0f0583525 brw-rw----
sdb    iso9660 cidata          2023-06-07-16-13-08-00               brw-rw----
sdc    iso9660 cidata          2023-06-07-16-13-08-00               brw-rw----\
```

**step2: create file system:**
```
> mkfs -t [filesystem_type] [block_name]
> mkfs -t ext4 /dev/sdb
```

**step3: check create filesystem result**


list up blocks
```
> sudo lsblk --output NAME,FSTYPE,LABEL,UUID,MODE
```
result:
```
NAME   FSTYPE  LABEL           UUID                                 MODE
sda                                                                 brw-rw----
└─sda1 ext4    cloudimg-rootfs f685bb41-0e3b-40c4-89c1-eea0f0583525 brw-rw----
sdb    ext4                    b91cedb6-16b9-44ee-9172-375f77773a36 brw-rw----
sdc    iso9660 cidata          2023-06-07-16-13-08-00               brw-rw----
```

**step4: mounting `filesystem` to `folder`**

create destination folder
```
> mkdir /tmp/data
```

mounting data
```
> mount [block_name] [dest_path]
> mount /dev/sdb /tmp/data
```

**step5: check mounting result**:

command:
```
> df -h
```

result:
```
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           1.5G     0  1.5G   0% /sys/fs/cgroup
tmp_gitlab-ci    92G   57G   36G  62% /tmp/gitlab-ci
tmpfs           301M     0  301M   0% /run/user/1002
#===========================here========================
/dev/sdb         19M   15K   17M   1% /tmp/data
```

**step6: Testing un-mount and mounting to other path**:

command un-mount
```
> umount [dest_path] or umount [block_name]
> umount /tmp/data or umount /dev/sdb
```

create new path:
```
> mkdir /tmp/data_new
```

mounting [/dev/sdb] to [/tmp/data_new]

```
> mount /dev/sdb /tmp/data_new
```

check result:
```
> ls -ltra /tmp/data_new/

total 18
drwx------  2 root root 12288 Jun 30 15:55 lost+found
-rw-r--r--  1 root root    15 Jun 30 15:57 testing.txt
drwxr-xr-x  3 root root  1024 Jun 30 15:57 .
drwxrwxrwt 12 root root  4096 Jun 30 16:19 ..
```

