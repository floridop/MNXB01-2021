#!/bin/bash
# testwhile.sh
# run with: ./testwhile.sh
#
# Continue asking to type until the user writes "STOP!"
while [ "$var1" != "STOP!" ]; do
  echo "Input variable value (STOP! to exit) "
  # read expects a variable name, not a value, so no $var1 here
  read var1
  banner $var1
  # If input is 'STOP!', echoes it here.
  # Does not test for termination condition until top of loop.
echo
done
