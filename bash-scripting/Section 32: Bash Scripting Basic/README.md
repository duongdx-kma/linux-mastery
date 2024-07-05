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