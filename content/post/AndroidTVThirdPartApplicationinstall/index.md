+++
date = '2025-05-18T21:39:12+08:00'
draft = false
title = '调试安卓TV（TCL）安装第三方应用的记录'
description = "AndroidTVThirdPartApplicationinstall"
math = true
image = "Logo_of_the_TCL_Corporation.svg"
categories = [
    "android","linux","TV"
]
+++

# 记录一下我调试家中TCL电视的过程

## 前提

TCL电视开启adb调试模式，开启方式请自行搜索，以及通过tclsu进行提权进入root用户，如果以上条件均具备，进行下一步，推荐先看完[参考连接](https://www.znds.com/tv-1204574-1-1.html) 再看本文

## 删除黑名单相关文件

首先，你要先连接上电视，使用`adb connect [IP]`的命令连接上，IP地址可以从入网路由器管理处或者是电视WiFi网络处找到，例如`adb connect 192.168.0.106`，然后确认一下是否有连接成功相关的返回，后面的操作可以通过`adb shell`进入adb shell窗口进行操作，[参考连接](https://www.znds.com/tv-1204574-1-1.html) 

adb shell 进入命令行可以验证su 或者是tclsu命令是否生效，但由于adb shell命令内部不支持复制（目前我没找到复制办法，如有，请大神指出，可以回复在我的GitHub仓库连接内），我推荐的办法依旧还是基于cmd的，不需要进入adb shell内部进行操作

``````cmd
adb shell tclsu do busybox find / -name "*black*" > black.txt
``````

解释一下，`adb shell [command]`会跳入adb shell内部执行命令后将返回值输出到cmd窗口，所以`adb shell ls`会直接显示下面的文件， 而`tclsu do`则是表示提权之后进一步在内部进行的操作命令，因为有些文件夹没有root权限不可访问，避免很多的拒绝访问出现刷屏，再有就是因为这是基于cmd的，可以方便复制，也可以输出到文件，`> black.txt`即是这个意思，将找到的带black的字样的文件挨个删除，`mount -o remount -o rw /system`其中上文提到的链接可能需要在上述命令之前执行，最好带上`adb shell tclsu do`前缀执行，根据文章内描述逐个执行

```bash
cd /system/etc/
rm -r ./FF-CN-T962A2-J55_black_list.json
rm -r ./TCL-CN-T962-A360_black_list.json
rm -r ./TCL-CN-T962-A460_black_list.json
rm -r ./TCL-CN-T962-A730U-UD_black_list.json
rm -r ./TCL-CN-T962-D6_black_list.json
rm -r ./TCL-CN-T962-P2-UD_black_list.json
rm -r ./TCL-CN-T962-V2_black_list.json
rm -r ./TCL-CN-T962A-E5800A-UD_black_list.json
rm -r ./black_list.json

rm -r ./appinfo/blacklist_FF-CN-T962A2-J55.xml
rm -r ./appinfo/blacklist_TCL-CN-T962-A360.xml
rm -r ./appinfo/blacklist_TCL-CN-T962-A460.xml
rm -r ./appinfo/blacklist_TCL-CN-T962-A730U-UD.xml
rm -r ./appinfo/blacklist_TCL-CN-T962-D6.xml
rm -r ./appinfo/blacklist_TCL-CN-T962-P2-UD.xml
rm -r ./appinfo/blacklist_TCL-CN-T962-V2.xml
rm -r ./appinfo/blacklist_TCL-CN-T962A-E5800A-UD.xml
```

## 清理系统预装的垃圾软件

接下来可以进行一些清理

```cmd
C:\Users\Deepblue\Desktop>adb shell tclsu do pm list packages >package.txt
```

这一行命令的意思是，会将所有包名导出到package.txt文本文件中，在其中找到你一些冗余的包进行卸载，其中我的日志会随后附在我的博客中，可供参考，

```cmd
adb shell tclsu do pm uninstall --user 0 com.tcl.bootadservice
adb shell tclsu do pm uninstall --user 0 com.golive.cinema
adb shell tclsu do pm uninstall --user 0 com.audiocn.kalaok.tv
adb shell tclsu do pm uninstall --user 0 com.tcl.tshop
adb shell tclsu do pm uninstall --user 0 com.tcl.gamecenter
adb shell tclsu do pm uninstall --user 0 com.tcl.common.weather
```

（谁会用电视搞这些有的没的啊，还捆绑成系统应用）

## 安装第三方软件

系统默认你禁止安装软件，但是可以通过命令行解除，好像规则是每次adb发起的连接只要不断开就一直能安装，解除命令如下：

```cmd
adb shell tclsu do setprop persist.tcl.debug.installapk 1
adb shell tclsu do setprop persist.tcl.installapk.enable 1
```

(ps:哪怕你关闭了cmd窗口也依然生效，因为你在cmd输入adb命令已经启动了adb工具了，可以在任务管理器中看到，所以哪怕你换窗口也依旧没关系，因为adb没关闭，adb connect IP地址依旧维持着,除非你kill了adb.exe的进程)

```cmd
adb shell getprop ro.build.version.release
5.0.1
```

以及记得查看支持的安卓版本，这是我的输出，5.0.1，几乎可以装所有应用，但是记得检查最低适配版本，以及，这个本身对我而言是为了装一个支持NAS的软件到TCL上方便我远程看存在硬盘里的番才这么折腾的，网上说有个网络存储，然后我家的TCL电视只支持自己扫描，不允许自己输入IP地址，网上查了一下AI，装了ES文件浏览器，发现也不行，没找到允许输入密码的远程软件，最后一想，我手机上用的cx文件管理器应该也差不多，一装上，能用，那就暂时固定下来了

