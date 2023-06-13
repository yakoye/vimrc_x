#!/bin/bash
set -x

cp -f ~/.bashrc bashrc
rm -f ~/vimrc_ye_cfg.zip
zip -r ~/vimrc_ye_cfg.zip bashrc vimrc-ex vim package_vimrc_ye_cfg.sh
