# Section 33: Build Robust Bash Scripting

## I. Pipe vs Process substitution

### 1. Remainder: Process substitution

#### a. normal pipe
```
- ls | wc -l
- the output of `ls` command is being used as stdin of `wc -l` command
```

#### b. process substitution `<(command)` :
```
- wc -l < <(ls)
- the command `ls` will be executed it's result will be written to a temporary file
-  and this temporary file will be used as the input for redirection(which will then load the file into the stdin of `wc -l`)
```

#### c. pipe vs process: first comparison

**Pipe**
```
- Command: `ls | wc -l`
- `ls` is executed is the main-shell
- `wc -l` is executed in a sub-shell
```

**Process substitution:**
```
- command: `wc -l < <(ls)`
- `wc -l` is executed in the main-shell
- `ls` is executed in a sub-shell
```

**conclusion**
```
- Here, it doesn't make any difference
```

#### d. pipe vs process: `difference`

**Pipe**:
```
- `echo "Linux" | read -r topic`
- read -r topic is executed in a sub-shell
- Thus, the variable exists only in the sub-shell
- If we try to access this variable after, it will not exist in the main process
```

**Process substitution:**
```
- `read -r topic < <(echo "Linux")`
- read -r topic is executed in the main shell
- Thus, this variable exists after the command!
```

## II: split a Bash script into multiple files:

**We can just launch the other script in a sub-shell:**
```
- bash other-script.sh
- ./other-script
- But this will launch the other script in a sub-shell
- Meaning: We have a different scope for our variables
- Only environment variables are inherited from the parent to the other script
```

**We can also execute a Bash script in the same context as our current script:**
```
- source [file]
- source ./other-script.sh
```

## III: Best practices for shell scripts
```
- There're different style guides available for Bash scripts
- A style guide:
- A collection of rules and best-practices to follow
- This allows multiple team members to have a common code style, and follow common rules
- This makes collaboration significantly easier
- I would like to especially mention the following guide:
- Shell Style Guide by Google
- https://google.github.io/styleguide/shellguide.html
- I personally try to follow this guide by 90%+
```

## IV: Finding and preventing bugs
```
- Shellcheck checks and analyzes your shell scripts
- And gives you tips how to prevent bugs
```
**Example:**
```
- Syntax validation: Detects and alerts us for syntax errors
- Code safety: Finds common pitfalls, and reduces the chance of
unexpected behavior
- Style recommendations: It helps us to adhere to coding standards
- In general: It helps us to optimize our script
```

**Usually, we must install this tool first:**
```
- Ubuntu: apt install shellcheck
- CentOS: dnf install shellcheck (EPEL must be enabled)
- Mac: brew install shellcheck
- (Homebrew must be installed: https://brew.sh)
```