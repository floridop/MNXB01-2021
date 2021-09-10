#!/bin/bash

# capture the output of the id command in a variable
USERINFO=$(id pflorido)

# extract the main group by using pipe and the cut command
MAINGROUP=$(id pflorido | cut -d' ' -f 1)

echo "USERINFO is: $USERINFO" 
echo "MAINGROUP is: $MAINGROUP"

# same as above but using the pipe on the variable content
echo "MAINGROUP reusing the \$USERINFO variable content:"
echo "$USERINFO" | cut -d' ' -f 1
