# op-ssr-ar71xx-18.06.4

运行在OpenWRT 18.06.4 上的 SSR。

编译中遇到的问题和解决办法：其中的cdns 和另一个dnsmasq-extra的软件包需要 argp-standalone, 这时就要修改`feeds.conf.default`文件，将`base`的代码仓库修改为`github.com`，然后运行`./scripts/feeds update base`，再运行`./scripts/feeds install argp-standalone`安装`base`里的`argp-standalone`软件包。

## 建立 SSH 隧道（OpenWRT）

1、需要安装`openssh-client`。原来的Dropbear ssh 客户端不兼容。

2、需要服务器上的列入到`authorized_keys`中`id_rsa.pub`对应的`id_rsa`（服务器上列入到`authorized_keys`的`id_rsa.pub`有两个，一个是`neo_laptop`，另一个是`unisko@gmail.com` Github账号的`id_rsa.pub`), 因此应将`neo_laptop`的`id_rsa`上传到`/etc/dropbear/`

3、需要将服务器上的`id_rsa.pub`加入到`/etc/dropbear/authorized_keys`，以便今后不用每次输入密码
