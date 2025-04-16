+++
date = '2025-04-11T23:00:45+08:00'
draft = false
title = 'Ubuntu使用指南'
math = true
image = "Ubuntu-logo.png"
categories = [
    "ubuntu","linux"
]
+++

# 一些实用功能

> 终端环境下的文件传输工具lrzsz
```bash
sudo apt install -y lrzsz
```
使用即是在Ubuntu终端环境输入rz即可使用

> 移动文件:mv
```
mv  --option (source_file|source_folder) (target_file|target_folder)
```

> apt
sudo apt search
机制是在source.list中找是否有对应的包，镜像中
sudo apt clean清理缓存 

> 压缩解压工具 7zip
 sudo apt install p7zip-full

## vim
ctrl f向下翻页
ctrl b向上翻页

/UUID
回车
n N
## 更改时区

sudo timedatectl set-timezone Asia/Shanghai

## 关机
shutdown
-P 关机
-r 重启
now立即
shutdown -r now