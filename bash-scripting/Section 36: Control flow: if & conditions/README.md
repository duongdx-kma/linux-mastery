# Section 36: Control flow: if & conditions

## I. Exit code in Bash:
```
- If a program exists, it provides an exit code, which indicates the `success` or `failure` of its execution.
- Exit code 0 is considered true, and any non-zero value is considered false
- Exit code 0 -> `success`,
- non-zero value (e.g., 1, or anything else) -> `failure`
- You can access the exit code of the last command using the special variable `$?`
```

## II. Chaining commands

### 1. combine multiple commands `AND`:

**method 1: [command1] && [command2]**
```
> [command1] && [command2]

Only executes the next command, if the first commands exit code is 0
```

**method 2: [command1]; [command2]**
```
> [command1]; [command2]

Always executes the next command
```

**Example method 1: [command1] && [command2]**
```
> touch testing1.txt && touch testing2.txt
```

**Example method 2: [command1]; [command2]**
```
> touch testing1.txt; touch testing2.txt
```

### 2. Chaining commands with `OR`:

**[command1] || [command2]**
```
[command1] || [command2]
- In this case, a logical OR is being applied
- This means:
- If the first command executes successfully (exit code 0):
- The second command will not be executed
- If the first command executes unsuccessfully (exit code not equal to 0):
- The second command will be executed
```

**example:**
```
> touch duongdx98.txt || touch duongdx98_other.txt

# result:
- `touch duongdx98.txt` exit code 0 ==> duongdx98.txt  is created
- `touch duongdx98_other.txt` is skipped
```


```
> touch dfsdfsdfsdfdsfs34234234 || touch duongdx98_other.txt

# result:
- `touch dfsdfsdfsdfdsfs34234234` exit code 1 ==> duongdx98.txt  is created
- `touch duongdx98_other.txt` exit code 0
```

## III. Testing values

** If we want to test values, we can use [[ ... ]] for this:**
```
- [[ condition ]]
- This will then set the exit code:
- 0: If the condition has been fulfilled
- 1: If the condition has not been fulfilled
```

**Example:**
```
- [[ "hello" == "hello" ]]
- Condition fulfilled, exit code will be 0

- [[ "hello" == "world" ]]
- Condition not fulfilled, exit code will be 1

- [[ "hello" != "world" ]]
- Condition fulfilled, exit code will be 0

- [[ "${name}" == "max" ]]
- This depends on the contents of the variable name
```

## IV. The `if` statement
```
The if statement is used for conditional branching based on the result of a test or exit status
```

### 1. Syntax:
```
if command; then
 # Code to be executed if the exit code is 0
else
 # Code to be executed if the exit code is not 0
fi
```
### 2. Important:
```
- It does not matter for the if how the exit code has been generated
- Thus, we can just use:
- if [[ "${name}" == "Max" ]]; then
```

### 3. The `elif` statement

**introduction**
```
- The elif statement allows you to evaluate multiple conditions in a
series of if statements
```

**Syntax:**
```
if command1; then
 # Code to execute if command1 is true (exit code = 0)
elif command2; then
 # Code to execute if command2 is true (exit code = 0)
else
 # Code to execute if no previous conditions are true
fi
```

**notes:**
```
- Conditions are evaluated from top to bottom
- Once a condition is found to be true, the corresponding code block is executed, and all remaining conditions are skipped
```

## V. Testing strings

### 1. check string:
```
# for example:
[[ "${filename}" == 'data.csv' ]]
```

### 2. To check if a variable is of length zero:

**method 1: would work:**
```
[[ "${filename}" == '' ]]
```

**method 2: preferred:**
```
[[ -z "${filename}" ]]
```

### 3. To check if a variable is `not` of length zero:

**method 1: would work:**
```
[[ "${filename}" != '' ]]
```

**method 2: preferred:**
```
[[ -n "${filename}" ]]
```

### 3. Heads up: [[ ... ]]
```
- Technically, [[ ... ]] also supports =
- It is treated in the same way as ==
- Thus, those would be equivalent:
- [[ "${filename}" == 'data.csv' ]]
- [[ "${filename}" = 'data.csv' ]]
- But we should try to always use ==
- It's more clear
```

## VI: pattern matches

### 1. We can also check if a pattern matches

```
- [[ "file.txt" == *.txt ]]
```
**Important:**
```
- Filename expansion is disabled within [[ ... ]]
- Different syntax rules apply within the square brackets
- The * means that we want to match any string, including the empty string
- A ? sign would match any single character
- [...] matches any single character within the square brackets
```

**Important:**
```
- This is not a regular expression!
- Also, more complex pattern matching is available:
- https://www.gnu.org/software/bash/manual/html_node/PatternMatching.html
```

### 2. We can also check for a regular expression:
```
- [[ "file.txt" =~ \.txt$ ]]
- Here, we check that the variable filename ends with .txt, but
through a regular expression
- More on those later!
```

## VII: check for files:

### 1. we can check -f files:
```
[[ -e "${file_name}" ]]
```

### 2. option:
```
    -e: file exists
    -f: Regular file
    -d: Directory
    -r: Readable
    -w: Writable
    -x: Executable
```

### 3. example: list file
```
-rw-r--r--. 1 deploy deploy   1239 Jul  7 19:27 api.json
-rw-r--r--. 1 deploy deploy      0 Jul  8 09:11 duongdx98.txt
--w-------. 1 deploy deploy      0 Jul  8 11:10 duongdx_unreadable.txt
drwxr-xr-x. 2 deploy deploy      6 Jul  8 11:12 duongdx_folder
```

### 4. testing:

**-d: Directory**
```
# command
> [[ -d 'duongdx_folder' ]]; echo $?

# result: 0 (true)

# command
> [[ -d 'duongdx_unreadable.txt' ]]; echo $?

# result: 1 (false)
```

**-e: file exists**
```
# command
> [[ -e 'duongdx_unreadable.txt' ]]; echo $?

# result: 0 (true)
```

**-r: Readable**
```
# command
> [[ -r 'duongdx98.txt' ]]; echo $?

# result: 0 (true)

# command
> [[ -r 'duongdx_unreadable.txt' ]]; echo $?

# result: 1 (false)
```

**-w: Writable**
```
# command
> [[ -w 'duongdx98.txt' ]]; echo $?

# result: 0 (true)

# command
> [[ -w 'duongdx_unreadable.txt' ]]; echo $?

# result: 0 (true)
```

**-x: Executable**
```
# command
> [[ -x 'duongdx98.txt' ]]; echo $?

# result: 0 (true)

# command
> [[ -x 'duongdx_unreadable.txt' ]]; echo $?

# result: 1 (false)
```

## VIII: Number comparison:

### 1. using [[ ... ]]

**option**
```
    -lt: Lower than
    -le: Lower than or equal
    -gt: Greater than
    -ge: Greater than or equal
```

**Example:**
```
    [[ "${num_files}" -gt 15 ]]
    [[ "${num_files}" -ge 15 ]]
    [[ "${num_files}" -lt 15 ]]
    [[ "${num_files}" -le 15 ]]
```

### 2. using (( ... )) arithmetic expression

```
(( num_files > 15 ))
```

**Remember:**
```
- Within arithmetic expression, different syntax rules apply
- We can access variables without a $
```

## IX. More complex conditions

### 1. Negation:

**intro**:
```
!: negate a condition
```

**Example:**
```
[[ ! -e "${filename}" ]]
```

### 2. Logical Operators:

**intro**
```
- We can also combine conditions with logical operators:
- && for a logical AND
- || for a logical OR
```

**Example:**
```
- num=6;
[[ "${num}" -gt 5 && "${num}" -lt 10 ]]
[[ "${num}" -gt 10 || "${num}" -lt 0 ]]

- But we could also write it like this (only for &&):
[[ "${num}" -gt 5 ]] && [[ "${num}" -lt 10 ]]
```

## X. The case statement
```
case expression in
 pattern1)
 # Code to execute if expression matches pattern1
 ;;
 pattern2)
 # Code to execute if expression matches pattern2
 ;;
 pattern3)
 # Code to execute if expression matches pattern3
 ;;
 *)
 # Code to execute if expression does not match any patterns
 ;;
esac
```

# example
```
case $distribution in
    "Mac")
        echo "On Mac os, you are rick kid ~.~"
    ;;
    "Ubuntu")
        echo "On Ubuntu os, you are developer </>"
    ;;
    "Window")
        echo "On Window os, you are normal user ~~~"
    ;;
    *)
        echo "default case..."
    ;;
esac
```