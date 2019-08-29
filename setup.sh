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

pkgs_install () {
    wget -4 --no-check-certificate -O /tmp/pkgs_need ${downloadPrefix}"pkgs_need"

    install_seq="cdns ChinaDNS dnscrypt dns-forwarder dnsmasq-extra libmbedtls shadowsocksr-libev luci-app-shadowsocksr"
    for pkg_name in ${install_seq}; do
       pkg=`/bin/cat /tmp/pkgs_need | grep "${pkg_name}"`
       
       wget -4 --no-check-certificate -O /tmp/${pkg} ${downloadPrefix}${pkg}

       /bin/opkg install /tmp/${pkg}
    done;
}

# set timezone
set_tz () {
    tz_reload=0

    if [ "`/sbin/uci get system.@system[0].zonename`" != "Asia/Shanghai" ]; then
        tz_reload=1
        /sbin/uci set system.@system[0].zonename=Asia/Shanghai
    fi;

    if [ "`/sbin/uci get system.@system[0].timezone`" != "CST-8" ]; then
        tz_reload=1
        /sbin/uci set system.@system[0].timezone=CST-8
    fi;

    if [ $tz_reload -eq 1 ]; then
        /sbin/uci commit system
        /sbin/reload_config
    fi;
}

set_tz
update_opkg_repo
update_old_pkgs
pkgs_install
