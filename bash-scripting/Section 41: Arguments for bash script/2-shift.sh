#!/usr/bin/env bash

echo "---"

echo "argument 0: ${0}"
echo "argument 1: ${1}"
echo "argument 2: ${2}"
echo "argument 3: ${3}"
echo "number of variables: $#"

shift 2

echo "argument 0: ${0}"
echo "argument 1: ${1}"
echo "argument 2: ${2}"
echo "argument 3: ${3}"
echo "number of variables: $#"
