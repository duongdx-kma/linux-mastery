# Bash Scripting Basic

## I. Shebang:

### 1. introduction
```
- Bash scripts should begin with a shebang at the top, specifying
the interpreter for executing the script
- An interpreter reads a script line by line, interprets each command, and executes them in sequence:
- # (sharp) + ! (bang) = shebang
- This is a Unix feature: The statement after #! is executed as an interpreter for the script

Example:
- #!/usr/bin/env bash
  echo 'hello from a bash script'
```

### 2. comment:

**introduction**
```
- Comments in Bash start with a single `#`

- Sometimes, you might see comments with `:`
    + : I am a comment
    + Technically, : stands for NOP, meaning that we execute an empty command
    + Expansions are still being applied
    + This is not a real comment, and should not be used as such
```

**multi-line comment as such:**
```
: << 'my_command'
This here is the content of the comment. Hello world!
hello
my_command
```

**insert multiple lines to file with `EOF`: we can override `EOF` with anything (it must same with `first` and `end` of sentences)**
```
cat << EOF | tee duongdx.txt  
There are the content which will be append to duongdx.dx file !
hello duongdx
EOF
```

```
cat << duongdx_file | tee duongdx_file.txt  
There are the content which will be append to duongdx.dx file !
hello duongdx
duongdx_file
```

### 3. Bash variable:

**`bash variables`: best practices**
```
- Avoid using special characters or reserved keywords
- Try to using Bash variables, unless you need to using an environment variable
- you can simplify complex commands, by using a variable to turn them in to multiple, simpler commands
- Use lowercase characters, and separate word by an '_': example: my_host
```

### 4. Bash variables vs Environment variables

**Environment variables:**
```
- A feature of the operating system
- They work independently of the program / programming language
- They are automatically inherited to child processes
```

**Bash variables:**
```
- A feature of Bash
- They work within a single Bash context
- They are not inherited to child processes
```

**Best practice**
```
- Use Bash variables whenever possible
- Use environment variables when you want those to be
inherited to child processes
```

### 5. Declare variables `errors`:

**Error_1: variable_name= value**
```
- We create an temporary environment variable variable_name and set it to ''
- After that, we execute value with this environment variable
- variable_name =value
- Bash will execute variable_name as a command with the
```

**Error_2: parameter =value**
```
- Most likely, the command variable_name will not exist, thus
yielding an error
```

**Error_3: variable_name = value**
```
- Bash will execute variable_name as a command with 2 parameters: '=' and 'value'
```

### 6. Declare variable:

**Syntax:**
```
- declare [options] variable_name=value
- Options (examples):
  -r: declares a read-only variable that cannot be modified
  -i: Declares an integer variable
  -x: Declares an environment variable
```

**Example:**
```
- declare -r course_title='Linux'
- This variable is now read-only, and cannot be changed
```


**display all declare variables:**
```
# command:
- declare -p
or
- declare -p [variable_name]

# result:
...
declare -a DIRSTACK=()
declare -irx DUONGDX_AGE="22"
declare -- EPOCHREALTIME
declare -- EPOCHSECONDS
declare -ir EUID="1001"
declare -a FUNCNAME
declare -a GROUPS=()
...
```

### 7. unset command:

**Most often:**
- We never unset a variable
- Bash scripts are not that long anyway
- And once finished, our whole Bash process is removed from memory anyway

**Method 1: assign an empty value to a variable:**
```
- course_title=
- But this does not remove the variable
- The variable still exists (it's just set to the empty string)
```

**Really remove a variable:**
```
# command:
- unset [variable_name]

# example:
- unset course_title
```