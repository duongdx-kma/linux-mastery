#!/usr/bin/env bash

# normal way
# Here, we're using command substitution to execute the cat program
# Then, we collect its output and store it in the variable file_content
file_content="$(cat file.txt)"

# more efficient way
# '<' would normally be used for input redirection
# '<' means that we want to read the contents of the file
file_content_efficient="$(< file.txt)"
