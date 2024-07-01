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
or
> sudo lsblk -f
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
> mkfs -t [filesystem_type] [device_name]
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
> mount [device_name] [dest_path]
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
> umount [dest_path] or umount [device_name]
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

## III. Volume and Partition

### 1. What is a volume ?

**a. Partition**
```
- Partition is a part of a physical drive
- Separated from other parts of the drive
```

**b. Volume:**
```
- Volume is a logical storage unit on our computer
- It usually appears as an accessible driver or partition
- It can be more than just a partition:
   + Multiple partitions can be combined into one logical volume (LVM)
   + Or a volume can be stored on another computer and accessed
through the network
```

### 2. what is a mount ?

**a. the idea**
```
- We connect a filesystem to our directory tree
- This allows us to make it accessible to our programs
```

**b. we can mounting**
```
External, removable media (usually into a subfolder of /media)
   + Internal, permanent volumes (usually into a subfolder of /mnt)
   + External storage servers (for example: FTP)
   + Folders into other folders (bind mount)
- After we mounted a drive, it will become part of our directory tree
- And we can just cd into that folder
- Let's now have a look at how Ubuntu Desktop handles mounting
```

## IV. Mounting:

### 1. list up all devices
```
lsblk -f
The parameter -f tells the program that it should also show information about the filesystem
```

### 2. Command to mounting

**step1: create destination folder**
```
- mkdir /mnt/backups
```

**step2: mounting command**
```
> mount [device] [mount_point]

#Example:
> mount /dev/sdb2 /mnt/backups

# We can also specify the filesystem manually: -t ext4:
> mount -t ext4 /dev/sdb2 /mnt/backups


# Or add additional options (mounts as read-only):
> mount -o ro ext4 /dev/sdb2 /mnt/backups
```

**Step3: verify the mount:**
```
- mount or df -h
```

**Step4: unmount the drive with one of those commands:**
```
> umount /dev/sdb2
> umount /mnt/backups
```

### 3. Mount option:
```
Mount supports various mount options
Example options (ext4):
- ro: Read only
- rw: (default): Read + write
- noexec: Disables execution of executable files on the mounted filesystem
- nosuid:
   + Disables the set-user-identifier and the set-group-identifier on the mounted filesystem
   + Prevents a potential security risk!
- noatime: do not update access time when file is read
```

### 4 test `Mounting` option with `exfat`

**step1: install**
```
# Ubuntu:
> sudo apt install exfat-fuse exfat-utils

# Centos:
> sudo dnf install exfatprogs
```

**step2: create `filesystem`**
```
> sudo mkfs.exfat  /dev/sdb
```

**step3: mounting to folder and specific own user**
```
# check user:
> id

# result:
uid=1002(deploy) gid=1002(deploy) groups=1002(deploy),27(sudo),998(docker)

> sudo mount -t exfat -o uid=1002,gid=1002,umask=0027 /dev/sdb /mnt/data
```

## V. /etc/fstab:

### 1.What is the /etc/fstab?
```
- A system configuration file in Linux
- Defines how storage devices and partitions should be mounted
- It is being read during boot and allows us to automatically mount
volumes
```

### 2. /etc/fstab record format?
```
Each line represents a filesystem to be mounted
Fields (columns) are separated by spaces or tabs
- 1. Device identifier (UUID or device path)
- 2. Mount point
- 3. Filesystem type
- 4. Mount options
- 5. Dump option (dump is a backup utility, 0 = no backup)
- 6. Filesystem check order
- (fsck priority, 1 = root, 2 = non-root)
```

### 3. demo:
**a. get Device identifier (UUID)**
```
# run command to get UUID:
> lsblk -f
```

**b. /etc/fstab record example**
```
Example entry of the /etc/fstab file:
- UUID=aec067b7-c3cc-4b0d-97da-c4be187204f9 /mnt/backups ext4 defaults
0 2

# explain
- Device identified by UUID: aec067b7-c3cc-4b0d-97da-c4be187204f9
- Mount point: /mnt/backups
- Filesystem type: ext4
- Mount options: defaults (rw, suid, dev, exec, auto, nouser, and async)
- auto: should be mounted automatically
- nouser: Can only be mounted with root privileges
- async: reads and writes should be async. Improves performance, but can be
bad for data integrity on a power loss
- Dump option: 0 (disabled)
- Filesystem check order: 2 (non-root filesystem)
```

**c. /etc/fstab file content**
```
LABEL=cloudimg-rootfs	/	 ext4	defaults	0 1

#========================== This item here ==========================
UUID=4E0A-AD90 /mnt/data exfat uid=1002,gid=1002,umask=0027 0 2
```

**d. Refresh after mounting**
```
> sudo mount -a
```

## VI. checking a filesystem in case errors:
**command**
```
> sudo fsck [device_name]

or

> sudo fsck.[device_type] [device_name]

or

> journalctl -b
```

**example**
```
> sudo fsck /dev/sda1

> sudo fsck.ext4 /dev/sda1

> journalctl -b
```

## VII. Reduce filesystem and create new partitions:

**step1: usually, the filesystem needs to be unmounted**
```
# command:
> unmount [partition_name]

# example:
> unmount /dev/sdc1
```

**step2: we must run the filesystem check**
```
# command:
> fsck [partition_name] or fsck.[device_type] [partition_name]

# example:
> fsck /dev/sdc1 or fsck.ext4 /dev/sdc1
```

### 3: resize the filesystem
**command:**
```
> resize2fs [partition_name] [amount_of_volume]
```

**example:**
```
> resize2fs /dev/sdc1 500M
```

#### 4: resize the partition: using `parted`:
**command**
```
> parted [device_name]
```

**step0: go to partition:**
```
> parted /dev/sdc
```

**step1. print all partition**
```
# command
> (parted) print

# result
Number  Start   End     Size    Type     File system  Flags
 1      1049kB  2048MB  2047MB  primary  ext4
```

**step2. resize `partition_1`**
```
# command:
> (parted): resizepart

# Result:

> (parted): Partition number? 1
> (parted): End?  [2048MB]? 513
> (parted): Warning: Shrinking a partition can cause data loss, are you sure you want to continue?
> (parted): Yes/No? yes
```

**step3. re-check:**
```
# command:
> (parted): print

# result (partition have just reduced):
Number  Start   End     Size    Type     File system  Flags
 1      1049kB  513MB  512MB  primary  ext4
```

## VII. Reduce filesystem and create new partitions:

### step 1: create new partition for testing:

**step 1.1: go to device**
```
> parted /dev/sdc
```

**step 1.2 create new  partition**
```
> (parted) mkpart
> (parted) Partition type?  primary/extended? primary
> (parted) File system type?  [ext2]? ext4
> (parted) Start? 526MB
> (parted) End? 1038MB

# check result:
> (parted) print
Model: VBOX HARDDISK (scsi)
Disk /dev/sdc: 2147MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size   Type     File system  Flags
 1      1049kB  525MB   524MB  primary  ext4
 2      526MB   1038MB  512MB  primary  ext4         lba
```

**step 1.3 create new  folder and mounting data**
```
> mkdir /mnt/data_backup2
> mkfs.ext4 /dev/sdc2
> mount /dev/sdc2 /mnt/data_backup2
```

### step 2: extend partition:

**step 2.0: go to partition:**
```
> parted /dev/sdc
```

**step 2.1. print all partition**
```
# command
> (parted) print

# result
Number  Start   End     Size   Type     File system  Flags
 1      1049kB  525MB   524MB  primary  ext4
 2      526MB   1038MB  512MB  primary  ext4         lba

```

**step 2.2. resize `partition_1`**
```
# command:
> (parted): resizepart

# Result:

> (parted): Partition number? 2
> (parted): End?  [1038MB]? 1550  

# check
> (parted) print
Number  Start   End     Size    Type     File system  Flags
 1      1049kB  525MB   524MB   primary  ext4
 2      526MB   1550MB  1024MB  primary  ext4         lba

```

**step 2.3. re-check:**
```
# command:
> (parted): print

# result (partition have just reduced):
Number  Start   End     Size    Type     File system  Flags
 1      1049kB  513MB  512MB  primary  ext4
```

**step 2.4. restart partition:**
```
> sudo resize2fs /dev/sdc2
```
