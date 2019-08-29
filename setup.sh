#!/bin/sh
downloadPrefix="https://raw.githubusercontent.com/gnu4cn/op-ssr-ar71xx-18.06.4/master/"
TRIES=4

update_opkg_repo () {
    repo_update_tries=0
    until [ $repo_updated -eq 1 -o $repo_update_tries -gt $TRIES ]
    do
        /bin/opkg update
        if [ $? -eq 0 ]; then
            repo_updated=1
        fi;
        repo_update_tries=$((repo_update_tries+1))
    done;
}

update_old_pkgs () {
    /bin/opkg list-upgradable > /tmp/pkgs_upgradable.tmp

    for pkg in `/bin/cat /tmp/pkgs_upgradable.tmp`; do
        pkg_name=`/bin/echo "${pkg}" | awk -F ' ' '{printf $1}'`
        /bin/opkg upgrade "${pkg_name}"
    done;
}
