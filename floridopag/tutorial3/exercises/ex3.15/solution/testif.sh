#!/bin/bash
# testif.sh
# run with: ./testif.sh arg1 arg2 arg3
#
# test that at least three arguments are passed to the script
if  [[ $# -le 2 ]];  then
    echo "Not enough arguments. Must be at least 3!";
    exit 1;
else
    echo "More than 2 arguments. Good!";
fi

# test that the first two parameters differ
if [[ $1 == $2 ]]; then
    echo "Error: the first two parameters are the same string";
    exit 1;
else
    echo "Good: the first two parameters differ.";
    exit 0;
fi

