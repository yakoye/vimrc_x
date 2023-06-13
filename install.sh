#!/usr/bin/env bash

# Date: 2023-06-12
# Author: yepengyu


today=`date +%Y%m%d_%s`

if [ -e ~/.vim ] || [ -e ~/.vimrc ]; then
    [ -e ~/.vim ] && mv ~/.vim ~/.vim_$today
    [ -e ~/.vimrc ] && mv ~/.vimrc ~/.vimrc_$today
    echo "Files or folders renamed successfully."
fi

curt_path=$(cd "$(dirname "$0")";pwd)
echo $curt_path

ln -snf $curt_path/vimrc-ex ~/.vimrc
ln -snf $curt_path/vim ~/.vim

[ -e ~/.vim ] && echo "vim => ~/.vim"
[ -e ~/.vimrc ] && echo "vimrc-ex => ~/.vimrc"

