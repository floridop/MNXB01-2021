#!/bin/bash

# put the first two lines of /proc/cpuinfo in CPUINFO
CPUINFO=$(cat /proc/cpuinfo | head -2)

# write the content of CPUINFO to screen
echo "First 2 lines of /proc/cpuinfo:"
echo "$CPUINFO"


# put the first four lines of /proc/meminfo in MEMINFO
MEMINFO=$(cat /proc/meminfo | head -4)

# write the content of MEMINFO to screen
echo "First 4 lines of /proc/meminfo:"
echo "$MEMINFO"


# put the first line of /etc/sysconfig/network in HOST
HOST=$(cat /etc/sysconfig/network | head -2)

# write the content of MEMINFO to screen
echo "First 2 lines of /etc/sysconfig/network:"
echo "$HOST"

