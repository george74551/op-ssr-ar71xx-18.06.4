#!/bin/sh

for pkg in `/bin/cat pkgs_need`; do
    echo ${pkg};
done
