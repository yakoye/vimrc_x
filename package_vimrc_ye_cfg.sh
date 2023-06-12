#!/bin/bash
set -x

cp -f .bashrc bashrc
cp -f .vimrc vimrc
rm -f vimrc_ye_cfg.zip
zip -r vimrc_ye_cfg.zip bashrc vimrc .vim package_vimrc_ye_cfg.sh
rm -f bashrc vimrc
