#!/usr/bin/env bash

echo "this is the parent.sh"

declare -r city='HaNoi'

# invoke sub shell
source ./child.sh

# print environment from sub shell
echo "${ENV_CITY}"