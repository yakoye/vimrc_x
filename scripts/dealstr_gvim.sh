#!/bin/bash

xx=`echo $1 | sed -s "s/\:/\ \+/" | sed -s "s/\:/\ /g"`
gvim $xx $2
