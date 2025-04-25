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

## 查看开放端口状态

netstat -tuln

## ssh密钥

```bash

root@deepblueubuntu:/home/deepblue# ssh-keygen 
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): /roo	^H^H^H^H^H^C
root@deepblueubuntu:/home/deepblue# ssh-keygen 
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): /root/.ssh/deepblue_rsa
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/deepblue_rsa
Your public key has been saved in /root/.ssh/deepblue_rsa.pub
The key fingerprint is:
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxx root@deepblueubuntu
```

生成完密钥之后使用下列命令：
```bash
cat /root/.ssh/deepblue_rsa.pub >> /root/.ssh/authorized_keys 
```

其中要把/root/.ssh/deepblue_rsa.pub替换成你使用的密钥名，这一步也就是把你生成的公钥加入认证密钥内
然后用vim编辑`/etc/ssh/sshd_config`文件
```bash
root@deepblueubuntu:/home/deepblue# vim /etc/ssh/sshd_config
```
取消以下内容的注释

```vim
PubkeyAuthentication yes # 允许公钥认证登录

PermitRootLogin prohibit-password # 禁止root用户通过密码登录

AuthorizedKeysFile      .ssh/authorized_keys  .ssh/authorized_keys2 # 指定公钥存放的位置
```

然后使用`esc :wq!`强制保存即可

```
sz /root/.ssh/deepblue_rsa
```

配合文件传输可以拿到密钥文件

## shell文件传输
安装以下包
sudo apt install -y lrzsz
命令工具为 sz 和 rz

以下内容来自AI
sz 和 rz 是基于 Zmodem 协议的文件传输命令，二者在使用场景和功能上存在明显区别，具体如下：
功能用途
sz ：用于将在 Linux 服务器上的文件发送到本地计算机。比如，当你在远程 Linux 服务器上通过终端操作，想要把服务器上的某个日志文件、配置文件等下载到本地时，就可以使用 sz 命令。
rz ：用于将本地计算机的文件上传到 Linux 服务器上。例如，需要把本地编写好的代码文件、配置文件等上传到服务器进行部署或使用时，rz 命令就能派上用场。