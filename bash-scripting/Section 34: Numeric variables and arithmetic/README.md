# Section 34: Numeric variables and arithmetic

## I. Calculate with Bash
```
- Bash can calculate with integers within double round
brackets: ((...))
- Within those brackets, we do not need a $ to access variables!
- For example:
> 'x=1' and 'y=2'
> (( result = x + y ))
echo "${result}"
```

## II. Integer in bash:

**We can declare the type of a variable:**
```
> declare –i ivar

- If we then assign a value to this variable, the expression will automatically be evaluated
- However, be careful:
- Integer variables will calculate math for us - it is possible to omit the round brackets in certain cases - but not always:
 x=4; y=3;
ivar=x+y
```

**Thus, best practice:**
```
- (( ivar = x + y ))
- ivar=$(( x + y ))
- Let's have a look in the co
```

## III. Decimal numbers in Bash
```
- bc: (basic calculator):
- It's a whole numerical programming language
- But usually, we only use it for floating point calculations in Bash
- It takes a string, and then runs the commands from that string

- For example:
> echo "12.3 + 4.5" | bc

- For division:
- We need to set a scale first! This specifies the number of decimal places for our result:
>  echo "scale=4; 12.3 / 4.5" | bc
```

## IV: The tool: `awk`

**awk '{ sum += $1 } END { print sum }' file**
```
- awk is a programming language to analyze text files
- It's especially useful for tabular data, or CSV files
- CSV: Comma separated values
- Because it's a separate programming language, we will not focus on awk in this course
- But I still want to provide you with 2 examples
- To sum up a file, we can use the following script:
- awk '{ sum += $1 } END { print sum }' file
- The first code block ({ sum += $1 }) is executed for each line
- The code block after the END is executed at the end
- Thus, the sum is calculated and printed at the endJannis Seemann -
```

**awk -F ';' '{ sum += $2 } END { print sum }' file**
```
- If you want to summarize a CSV file, you can configure the character by
which columns are being split
- Let's say the data was in the following format:
- Budapest; 1800000
- New York; 8500000
- London; 9000000
- How can we summarize the numbers?
> awk -F ';' '{ sum += $2 } END { print sum }' file
- First, we change the delimiter by which the columns are detected:
- -F ';'
- And then, we can just access the second column:
- $2
```