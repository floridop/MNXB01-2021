#!/bin/bash
# forexamples.sh
# run with: ./forexamples.sh
#

# countdown each second
for i in 2 4 8 16; do
    echo “now counting $i”
    # wait 1 second
    sleep 1
done

banner 'boom!'
