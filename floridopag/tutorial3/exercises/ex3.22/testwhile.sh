#!/bin/bash
# testwhile.sh
# run with: ./testwhile.sh
#
# Continue asking to type until the user writes “end”
while [ "$var1" != "end" ]; do
  echo "Input variable value (end to exit) "
  # read expects a variable name, not a value, so no $var1 here
  read var1
  echo "variable value = $var1"
  # If input is 'end', echoes it here.
  # Does not test for termination condition until top of loop.
echo
done
