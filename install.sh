#!/usr/bin/env bash

# Date: 2023-06-12
# Author: yepengyu


today=`date +%Y%m%d_%s`

if [ -e ~/.vim ] || [ -e ~/.vimrc ]; then
    [ -e ~/.vim ] && mv ~/.vim ~/.vim_$today
    [ -e ~/.vimrc ] && mv ~/.vimrc ~/.vimrc_$today
    echo "Files or folders renamed successfully."
fi

cp ./vimrc-ex ~/.vimrc
cp -r .vim ~

