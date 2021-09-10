#!/bin/bash

# test if an environment variable is defined
if [ "x$MYENV1" == "x" ]; then
	echo "MYENV1 not defined in the environment or empty. Please run"
        echo '  export MYENV1="This is my first environment variable. This is exported to all children processes"'
        echo
fi

# create an environment variable. Adds only to the environment of this script
MYENV2="This is my second environment variable, MYENV2 is defined only in this process"

# export and environment variable. Adds to the environment where this script is ran
export MYENV3="This is my third environment variable, exported. MYENV3 is defined in this process and in all children processes"

# write the content of the environment vars to screen
echo "Content of MYENV1: $MYENV1"
echo "Content of MYENV2: $MYENV2"
echo "Content of MYENV3: $MYENV3"

echo "Now check if MYENV2 and MYENV3 contents are still defined, with the commands:"
echo '  echo "Content of MYENV1: $MYENV1"'
echo '  echo "Content of MYENV2: $MYENV2"'
echo '  echo "Content of MYENV3: $MYENV3"'
echo
