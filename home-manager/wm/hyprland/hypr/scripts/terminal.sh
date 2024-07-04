#!/usr/bin/env bash

#********************************************
# Author      : lcdse7en                    *
# E-mail      : 2353442022@qq.com           *
# Create_Time : 2023-12-29 03:27:53         *
# Description :                             *
#********************************************

if [[ $1 == "-f" ]]; then
    kitty --single-instance --class "kitty_float"
else
    kitty --single-instance
fi
