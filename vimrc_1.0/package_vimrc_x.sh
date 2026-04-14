#!/bin/bash
set -x

cp -f ~/.bashrc bashrc
rm -f ~/vimrc_x.zip
zip -r ~/vimrc_x.zip bashrc vimrc_x install.sh vim package_vimrc_x.sh README.md

# unzip vimrc_x.zip -d vimrc_x
