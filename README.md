# op-ssr-ar71xx-18.06.4

运行在OpenWRT 18.06.4 上的 SSR。

编译中遇到的问题和解决办法：其中的cdns 和另一个dnsmasq-extra的软件包需要 argp-standalone, 这时就要修改`feeds.conf.default`文件，将`base`的代码仓库修改为`github.com`，然后运行`./scripts/feeds update base`，再运行`./scripts/feeds install argp-standalone`安装`base`里的`argp-standalone`软件包。
