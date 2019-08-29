#!/bin/sh

for pkg in `/bin/cat pkgs_need`; do
    echo ${pkg} | awk -F '_' '{printf $1}';
    echo '\n'
done
