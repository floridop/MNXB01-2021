#!/bin/bash
# testwhile.sh
# run with: ./testwhile.sh
#
# Continue asking to type until the user writes "STOP!"

STOPWORD='STOP!'

askinput(){
  echo "Input variable value ($STOPWORD to exit) "
  read var1
}

askinput

while [ "$var1" != "$STOPWORD" ]; do
  banner $var1
  askinput
echo
done

echo "$STOPWORD detected, exiting!"
