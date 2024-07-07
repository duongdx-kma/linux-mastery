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

## II. comment:

### 1. introduction
```
- Comments in Bash start with a single `#`

- Sometimes, you might see comments with `:`
    + : I am a comment
    + Technically, : stands for NOP, meaning that we execute an empty command
    + Expansions are still being applied
    + This is not a real comment, and should not be used as such
```

### 2. multi-line comment as such:
```
: << 'my_command'
This here is the content of the comment. Hello world!
hello
my_command
```

### 3. insert multiple lines to file with `EOF`: we can override `EOF` with anything (it must same with `first` and `end` of sentences)
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

## III. Bash variable:

### 1. `bash variables`: best practices
```
- Avoid using special characters or reserved keywords
- Try to using Bash variables, unless you need to using an environment variable
- you can simplify complex commands, by using a variable to turn them in to multiple, simpler commands
- Use lowercase characters, and separate word by an '_': example: my_host
```

## IV. Bash variables vs Environment variables

### 1. Environment variables:
```
- A feature of the operating system
- They work independently of the program / programming language
- They are automatically inherited to child processes
```

### 2. Bash variables:
```
- A feature of Bash
- They work within a single Bash context
- They are not inherited to child processes
```

### 3. Best practice
```
- Use Bash variables whenever possible
- Use environment variables when you want those to be
inherited to child processes
```

## V. Define variables `errors`:

### 1. Error_1: variable_name= value
```
- We create an temporary environment variable variable_name and set it to ''
- After that, we execute value with this environment variable
- variable_name =value
- Bash will execute variable_name as a command with the
```

### 2. Error_2: parameter =value
```
- Most likely, the command variable_name will not exist, thus
yielding an error
```

### 3. Error_3: variable_name = value
```
- Bash will execute variable_name as a command with 2 parameters: '=' and 'value'
```

## VI. Declare variable:

### 1. Syntax:
```
- declare [options] variable_name=value
- Options (examples):
  -r: declares a read-only variable that cannot be modified
  -i: Declares an integer variable
  -x: Declares an environment variable
```

### 2. Example:
```
- declare -r course_title='Linux'
- This variable is now read-only, and cannot be changed
```


### 3. display all declare variables:
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

## VII. unset command:

### 1. Most often:
- We never unset a variable
- Bash scripts are not that long anyway
- And once finished, our whole Bash process is removed from memory anyway

### 2. Method 1: assign an empty value to a variable:
```
- course_title=
- But this does not remove the variable
- The variable still exists (it's just set to the empty string)
```

### 3. Really remove a variable:
```
# command:
- unset [variable_name]

# example:
- unset course_title
```

## VIII. read user input:

### 1. introduction
```
Use the read command to prompt the user for input and store it in a variable:
> read -p 'Enter your name: ' name

# using `read` for multiple variables
- We can also read multiple values with just one read command:
> read [variable1] [variable2]

- Here, the input will be split into 2 segments:
  + The first word will be written into the variable [variable1]
  + All the remaining words will be written into [variable2]
```

### 2. Advanced read usage: IFS
```
- In Bash, the variable IFS controls how whitespace is being handled by certain commands
- The IFS variable is a Bash variable
- By default, it contains the following characters:
- space, tab, newline
- IFS=$' \t\n'
```

### 3. command
```
> read - [variable]
or
> read [variable1] [variable2]
```

## IX. Reading file content:

### 1. normal way"
```
- Here, we're using command substitution to execute the cat program
- Then, we collect its output and store it in the variable file_content

> file_content="$(cat file.txt)"
```

### 2. more efficient way:
```
- '<' would normally be used for input redirection
- '<' means that we want to read the contents of the file

> file_content_efficient="$(< file.txt)"
```