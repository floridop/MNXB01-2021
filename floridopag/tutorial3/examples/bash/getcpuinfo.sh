#!/bin/bash

# put the output of cat in the variable CPUINFO
CPUINFO=$(cat /proc/cpuinfo | head -7)

# write the content of CPUINFO to screen
echo "$CPUINFO"

