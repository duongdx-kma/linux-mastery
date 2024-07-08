# Section 41: Arguments for bash script

## I. Arguments for a script

### 1. Passing argument to bash script:
```
> ./script argument1 argument2 argument3

Accessing the arguments:
- Program name (here: ./script): $0
- First positional argument: $1
- Second positional argument: $2
- (and so on)
```

### 2. Important:
```
- Expansions are still applied, before the script is executed
- This happens before our script is being executed
```


**Example: ./script `*`**
```
- This will search for all files in our current path
- Those will then be passed as an argument to our script
- The script itself will not be notified about the original command (before the expansion)!
```

**Example: ./script `*`**
```
# step1: check current directory
> ls -ltra

# step1: result
-rw-r--r--.  1 deploy deploy  4185503 Jul  8 16:35 image-8.jpg
-rw-r--r--.  1 deploy deploy  5104131 Jul  8 16:35 image-4.jpg
-rw-r--r--.  1 deploy deploy  2046538 Jul  8 16:35 image-3.jpg
-rw-r--r--.  1 deploy deploy  2718713 Jul  8 16:35 image-2.jpg
-rw-r--r--.  1 deploy deploy  3144487 Jul  8 16:35 image-1.jpg

# step2: run script
> ./1-argument-for-a-script.sh *

# step2: result
argument 0: './1-argument-for-a-script.sh'
argument 1: image-8.jpg
argument 2: image-4.jpg
argument 3: image-3.jpg
```

### 3. Arguments: Additional variables

**`$#`**
```
Number of positional arguments
```

**`$@`**
```
- Provides the positional arguments as an array
- (more on arrays later)
```

**`$*`**
```
Provides the positional arguments as a single string
```

**`$$`**
```
Provides the current process ID (PID)
```