# Section 12. Shell Expansions - How command are parsed

### 1. File expansions:
```
> ls -ltra: for example we have a bunch of files

Result:
- a.txt
- b.txt
- testing.txt
- alpha1.txt
- alpha2.txt
- alpha5.txt
- alpha25.txt
- beta.txt
- data.csv

# List files:

> ls *:

Result:
- a.txt
- b.txt
- testing.txt
- alpha1.txt
- alpha2.txt
- alpha5.txt
- alpha25.txt
- beta.txt
- data.csv

> ls *.txt:

Result:
- a.txt
- b.txt
- testing.txt
- alpha1.txt
- alpha2.txt
- alpha5.txt
- alpha25.txt
- beta.txt

> ls ?.txt:

Result:
- a.txt
- b.txt

> ls alpha?.txt:

Result:
- alpha1.txt
- alpha2.txt
- alpha5.txt
```

### 2. Tilde expansions (~):
```
the Tilde (~) equal $HOME env variable: ~ = $HOME

#for example:
> export HOME=/home/deploy

> echo ~ : /home/deploy

# for example:

> export HOME=/tmp/data

> echo ~ : /tmp/data
```

### 3. Variable and Parameter Expansions:

##### 3.1 get the length of environment variable:
```
> echo "${#VARIABLE_NAME}"
> echo "${#PATH}"
```

##### 3.2 get environment variable content range:
```
> echo "${VARIABLE_NAME:start:length}"

# taking 10 character, start from 20st
> echo "${PATH:20:10}"
```


### 4. check diff in 2 folder

##### 4.1 create 2 folder for testing purpose
```
# create 2 folder:
> mkdir folder1 folder2

# create files in folder
> touch folder1/testing{1..10}.txt
> touch folder1/testing{18..19}.txt

> touch folder1/testing{1..15}.txt

# checking structure:
> apt-get install tree
> tree .
```

##### 4.2 create 2 file for checking
```
# list up all file in folder1
> ls folder1/ > folder1_contents.txt

# list up all file in folder2
> ls folder2/ > folder2_contents.txt
```

##### 4.3 using `diff` command to check differences
```
> diff folder1_contents.txt folder2_contents.txt

Result:
2a3,7
> testing11.txt
> testing12.txt
> testing13.txt
> testing14.txt
> testing15.txt
11,12d15
< testing18.txt
< testing19.txt

```

##### 4.4 instate create 2 physical file: using `<()`
```

# list up all file in folder1
> ls folder1/ > folder1_contents.txt

# list up all file in folder2
> ls folder2/ > folder2_contents.txt

# check diff:
> diff folder1_contents.txt folder2_contents.txt


INSTATE:

> diff <(ls folder2/) <(ls folder1/)

```