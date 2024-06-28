# File in Unix

## 1. /etc/sudoers

##### 1.1 username ALL=(ALL:ALL) ALL
```
username ALL=(ALL:ALL) ALL

- username: the username, this rule should be applied to this user
- ALL: the hostname that this rule should apply to
- (ALL:ALL): The run configuration
    + first ALL: The user that user username can sudo into (for example: sudo su - executor)
    + second ALL: the group that user username can sudo into

- ALL: the command specification, ALL means any command
```

##### 1.2 sudo without password:
```
- we can specify NOPASSWD: to allow sudo without password (potential security risk)

- username ALL=(ALL:ALL) NOPASSWD: ALL
```

##### 1.3 we can also just allow specific programs
```
- username NOPASSWD: /usr/bin/apt-get
- username NOPASSWD: /usr/bin/composer
...
```

## 2. using sticky bit:

##### 2.1 Problem with normal permissions:
```
- The sticky bit is an extra bit that we can set for all files or
directories
- It has different meaning:
    + For files:
        (+) Obsolete, no longer used
        (+) It used to indicate that an executable file can remain in memory, to be loaded more quickly on next launch
    + For directories:
        (+) Without the sticky bit, any user with write + execute permissions for a directory can rename / delete files in it
        (+) If the sticky bit is set, only the owner (and root) of a file or the directory owner can rename or delete a file
- The sticky bit is especially used for the /tmp folder

example:
# create data folder
> mkdir /tmp/data

# change permission to 777
> chmod 777 /tmp/data

# using user user_a, create user_a_file.text
> user_a@hostname /tmp/data $: touch user_a_file.text
> user_a@hostname /tmp/data $: chmod 660 user_a_file.text

# using user user_b: user_b can delete, rename user_a_file.text
> user_b@hostname /tmp/data $: mv user_a_file.text user_aaaaa_file.text
> user_b@hostname /tmp/data $: rm user_a_file.text user_aaaaa_file.text
```

##### 2.2 Resolve permissions using STICKY BIT:
```

- Set sticky bit: chmod 1777 [folder]
- Unset sticky bit: chmod 0777 [folder]

> chmod 1777 /tmp/data or chmod +t /tmp/data

# checking
> ls -l

Result:

deploy@runner01:/tmp$ ls -l
total 20
drwxrwxrwt 2 deploy  deploy  4096 Jun 28 10:38 data
...

```

## 3. Advanced File Privilege - Set User ID (SUID) and Set Group ID (SGID):
```
```