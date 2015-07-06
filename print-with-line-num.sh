#! /bin/bash

# print source files with printer in a nice format
# works with 72 character lines

if [ -z "$1" ]; then
    echo "filename argument needed"
    exit
fi

cat $1 | sed -e 's:\t:    :g' | nl -w 3 -s   | lpr
