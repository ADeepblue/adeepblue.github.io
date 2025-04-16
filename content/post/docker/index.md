+++
date = '2025-04-14T23:21:09+08:00'
draft = true
title = 'Docker记录'
+++

# 记录一下折腾的过程



毕竟还是docker小白，虽然我当时安装服务器的时候默认安上了docker，但各种原因的限制下给卸了，重新去安装，

看到AI说推荐官方这样安装


```bash

# 更新包列表
sudo apt-get update

# 安装必要的包
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# 添加 Docker 的 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 添加 Docker 的 APT 仓库
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# 更新包列表
sudo apt-get update

# 安装 Docker CE 和 Docker Compose
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

```

然后就碰到了docker 安完了docker compose 命令不可用的问题，然后就涉及到镜像，
镜像听网上说因为一些不可描述的原因被封了，然后我也给整愣住了，查了很久，docker compose up命令好像可以通过docker-compose up替代，当时看到build路径没有东西以为不可用，想去网上找方案新建了一个sh脚本企图直接搞定，结果也没成，
然后仔细看docker-compose输出的时候才发现，貌似好像我不在环境中，并没有docker-compose.yml文件，进入环境依旧是不可用，但看着进一步了

感觉以后估计要手动安装包，apt install -y ./xxx.deb

```
deepblue@deepblueubuntu:~/my_projects/newsnow/newsnow-main$ docker-compose up
ERROR: Couldn't connect to Docker daemon at http+docker://localhost - is it running?

If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.
```

后面到AI给了这一步，我看到docker ps 有拒绝访问才意识到，得加一个sudo docker ps

验证 Docker 是否正常工作
运行以下命令验证 Docker 是否正常工作：

```bash
docker --version
docker ps
```

```bash
deepblue@deepblueubuntu:~/my_projects/newsnow/newsnow-main$ netstat -tuln | grep 4444
tcp        0      0 0.0.0.0:4444            0.0.0.0:*               LISTEN     
tcp6       0      0 :::4444                 :::*                    LISTEN     
```

虽然这样我昨天主机浏览器访问IP加端口依旧没奏效，curl也试过了，无法访问，也不知道是不是因为第一次启动，现在可以正常访问了