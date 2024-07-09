# Section 42: `function` in bash

## I. Variables with a `Function`

### 1. Important: Variables in Functions
```
- Important: Variables are global by default
- This means, that this will print out "Max":
```

**example `default variable (global)`**
```
my_function() { name='Max'; }

my_function
echo "${name}" # => Max
```

```
- To avoid this, we should use the local keyword:
- Then the variable will be local and valid within the function only
```

**example `local variable`**
```
my_function() {
    local name
    name='Max'
}

my_function
echo "${name}" # => null
```

### 2. Importance Notes
```
- Sometimes, storing data in global variables is useful in Bash
- Otherwise, we might need a lot of additional code just to bring data from one function to another

- If you do use global variables:
    + Be sure to add a commend above each function that uses them
    + And document their use!
```