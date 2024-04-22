#!/bin/bash

if [ $# -lt 1 ]
then
    echo "split huge file to 1024MB."
    echo "  Usage: splitfile filename"
    echo "  output: "
    echo "    filename_split_000   =1024MB"
    echo "    filename_split_001   =1024MB"
    echo "    filename_split_002   =1024MB"
    echo "    ......"
    exit
fi

echo "split $1 ..."
split -b 1024m -d -a 3  $1 $1_split_
