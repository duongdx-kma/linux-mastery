# Linux Environment Variable

course: https://udemy.com/course/mastering-linux/learn/lecture/38155492#overview

### 1. Edit PATH environment:

##### 1.1 check PATH environment:

```
> echo ${PATH}

Result:

/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

##### 1.2 create custom PATH environment:
```
# add new folder
> mkdir /home/deploy/bin

# edit PATH env variable:
export PATH="${PATH}:/home/deploy/bin"

# testing:
> echo $PATH

Result:
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/deploy/bin


> touch bin/custom_program
> chmod +x bin/custom_program
> which custom_program
```

### 2. Create custom executable file with Python:
```
# create hello_world
> mkdir /home/deploy/bin/hello_world

# make file executable:
chmod +x /home/deploy/bin//hello_world
```

### 3. create persistent variable (Bash startup files)
```
# Interactive login shell

> /etc/profile

> ~/.bash_profile
> ~/.bash_login
> ~/.profile

# Interactive Non-login shell
> ~/.bashrc

```