#!/bin/bash

trash_base="/tmp/trash"

if [ ! -d "$trash_base" ]; then
    mkdir -p "$trash_base"
    chmod 1777 "$trash_base"
fi

Date=$(date +%y%m%d_%H%M%S)
trash_dir="$trash_base/rm_$Date"

mkdir -p "$trash_dir"
mv "$@" "$trash_dir"

echo "delete Finish."
echo "move $@ => $trash_dir"

