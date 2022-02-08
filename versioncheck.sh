#!/bin/bash

# list version number pf critical development tools
export LC_ALL=C
bash --version | head -n1 | cut -d " " -f2-4
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"
echo $MYSH | grap -q bash | | echo "Error: /bin/sh does not point to bash"
unset MYSH

echo -n "Bin"