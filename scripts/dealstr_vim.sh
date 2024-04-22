#!/bin/bash

xx=`echo $1 | sed -s "s/\:/\ \+/" | sed -s "s/\:/\ /g"`
vim $xx $2
