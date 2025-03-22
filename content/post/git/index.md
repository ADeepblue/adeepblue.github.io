+++
date = '2025-02-04T21:39:19+08:00'
draft = false
title = 'Git初始化记录'
description = "方便下次初始化仓库"
image = "git-bash.svg"
categories = [
    "git"
]
+++

# 对git的一些我的个人见解

## 为什么要存在git这么个版本管理的工具

你现在手里有一个项目，这个项目可能会需要频繁改动，现在你的手里已经存在一个能用的项目代码，此时，一个你的客户向你提出某个要求，你开发过程中一不小心让程序闪退了，还不清楚什么原因，你还曾经因为用户需求改过一些底层函数的代码，
前去排查也毫无头绪，然后卡死在那了，你突然意识到，你好像需要一个备份，能看到你改动之前动了什么，你第一反应想到了新建文件夹

于是你这么做了，在你每次要进行更改的时候把存档备份先复制一份，然后再确认完之后再覆盖进去，改完之后覆盖了原来的版本，成功搞定了这一麻烦

但麻烦又接踵而至，后面你又不知道以前的版本是啥样的了，后开发的一些功能现在不需要，你开始烦恼，应该要怎么办，你想要一个既能看到以前版本的代码，又能有包含后面你开发代码的一个代码版本管理工具，刚好上网一搜，有git这么个版本管理工具，
甚至能看到以前的代码，于是你就去下下来拿过来用了

## git的一些核心功能

于是你开始研究这个叫Git的工具，发现它的核心思路就像给代码拍快照。每次改完一组功能，你都可以用git commit给当前代码拍张"照片"，照片背面还让你写上备注——比如"修复了登录闪退bug"或者"新增用户积分系统"。这比手动复制文件夹高明多了，因为所有版本都串成一条时间线，随时能穿越回任意节点。

你突然理解为什么要有暂存区了——就像做菜时的备料区。比如你同时改了用户模块和支付模块，但这次更新只涉及支付。你可以用git add把支付相关的改动"拣"到暂存区，确认无误后再打包成正式提交。而用户模块的改动还能留在工作区继续调试，完全不会污染这次提交的内容。

有次同事误删了关键文件，你第一次用git checkout从历史提交里捞回了文件。这让你想起小时候玩魂斗罗输光30条命后偷偷输入上上下下左右左右BA的作弊码——只不过Git的"时光倒流"是光明正大的。

随着项目复杂，你发现分支才是Git的精髓。开发新功能就像在平行宇宙开副本：用git branch feature新建分支随便折腾，做完后用git merge把成果同步回主分支。即使搞砸了，直接删掉这个分支就行，完全不影响主线代码，再也不用在文件夹后面加"最终版""最最终版"这种尴尬的命名了。

你还把仓库同步到GitHub，发现这个"代码云相册"能自动合并多人修改。虽然第一次遇到冲突时手足无措——你和同事同时改动了同一行代码，但Git会贴心标出差异，就像论文批改时的修订模式，让你们能协商着解决分歧。

现在每次提交前，你都会仔细写提交信息。有次排查半年前的bug时，通过git log看到当时的记录："修复用户ID溢出问题（ID超过32767会变成负数）"，直接定位到具体提交，比翻聊天记录高效十倍。你终于理解为什么资深开发者都把提交信息当小作文来写——这些文字就是穿越时空的线索啊。





# Git连接踩坑记录

## 配置SSH
重装电脑之后（并不重装D盘），git又连不上GitHub了，也不知道是出了什么毛病，
昨晚连接SSH都连不上，我只依稀记得以前踩了许多坑，再回过头来
捣鼓又是估计好一番功夫了，所以在这写下这篇文章为以后的我参考，方便以后快速配置
<br>`ssh -T git@github.com`<br>
`ssh -vT git@github.com  `(加了v之后会输出调试信息)<br>
也疯狂报错
报错信息如下
```
$ ssh -T adeepblue@github.com
/usr/bin/bash: line 1: exec: nc: not found
Connection closed by UNKNOWN port 65535
```

## 报错查找
但我依稀记得我当时折腾ssh和GitHub的时候没用nc代理工具，这回莫名奇妙有这个报错了
曾经的目录长这样
```bash
C:\Users\Deepblue\.ssh>dir /b
authorized_keys
id_ed25519
id_ed25519.pub
id_rsa.pub
id_rsa_2048
known_hosts
testpub
config
```

最后对比曾经重装电脑留下的备份文件发现多了一个config，然后点进去发现这玩意居然
显示要nc的配置什么的，幡然醒悟，哦，ssh出问题原来就是你这个文件捣的鬼，

文件内容如下:
```
Host github.com
  User git
  ProxyCommand nc -v -x 127.0.0.1:4780 %h %p
```
如果我当初没有备份目录我可能都没意识到，一删
除这个文件之后`ssh -T git@github.com`立马可以通了，也是给我整无语了



## 初始化仓库
# 仓库的配置，先需要初始化仓库
HTTPS协议的通道的演示：

```bash
git init
REM 新建并切到主分支（此处为cmd的备注方式）
git checkout -b main
REM 添加所有文件到git暂存区
git add .
REM 提交到分支
git commit -m "提交信息,比如init"
REM 配置代理，以我电脑上目前的科学上网工具为例，本地环路端口号为4780
git config --global http.proxy http://127.0.0.1:4780
git config --global https.proxy https://127.0.0.1:4780

REM git 添加你的仓库，此处不带git，因为我使用了SSH配置，所以也使用SSH的方式
REM 推送另一种方式我没用所以此处不写
REM 初次添加使用add，如果是一不小心输入错误需要修改就用第二条命令 set-url参数的
git remote add origin https://github.com/Adeepblue/adeepblue.github.io
git remote set-url origin https://github.com/Adeepblue/adeepblue.github.io
REM 推送，如果本地分支跟远程分支不同可使用-f参数强制推送
git push -f origin main / git push origin main --force

REM 列出所有配置
git config --list
REM 删除配置
git config --global --unset http.https://github.com.proxy
```
以上，调试完毕

如果走SSH协议的话，上面add origin或者是set-url origin后面的命令得修改成 git@github.com:Adeepblue/adeepblue.github.io，其中要确保SSH已经验证过了，

```bash
git add -f public
git commit -m "Publish site"
git subtree push --prefix public origin gh-pages
```
以及，现在的hugo推送，这样就可以推送到gh-pages分区进行展示了，需要GitHub修改一下仓库设置

![github页面图修改配置](1.png)

## 仓库迁移
最近自动化上传的时候遇到了这么个提示，也就是上面配置这边原始的命令那，git得补上了，我也不知道为什么，至少它现在提示了
```bath
remote: This repository moved. Please use the new location:        
remote:   git@github.com:ADeepblue/adeepblue.github.io.git   
```
然后我现在就用一行命令移动过去了

```
git remote set-url origin git@github.com:ADeepblue/adeepblue.github.io.git
```


## .gitignore文件
直接写入需要忽视的文件即可，可以让git add . 时跳过这些文件以回车分隔即可

## 自动化部署
我给一个我目前在用的自动化部署方案吧，我现在的仓库根目录是`E:\personal-blog\personal-blog`,我配置了我的自动化目录在`E:\personal-blog\automatical-test`
这里并不是git仓库的一部分，所以这个文件并不会上传，但是我分享在这里吧，仅作为参考，如果需要解析请移步隔壁cmd教程[cmd命令介绍](https://adeepblue.github.io/p/cmd%E5%91%BD%E4%BB%A4%E4%BB%8B%E7%BB%8D/)
```bath
REM E:\personal-blog\automatical-test\推送主分支.bat
@echo
cd ..
cd personal-blog
hugo
git add .

set "year=%date:~0,4%"
set "month=%date:~5,2%"
set "day=%date:~8,2%"
set "formatted_date=%year%-%month%-%day%"

git commit -m "Upload file in %formatted_date%"
git push -u origin main
pause
```

```bath
REM E:\personal-blog\automatical-test\发布文章.bat
@echo off
setlocal

rem 从 %date% 按位置提取年月日（假设格式固定为 YYYY/MM/DD）
set "year=%date:~0,4%"
set "month=%date:~5,2%"
set "day=%date:~8,2%"
set "formatted_date=%year%-%month%-%day%"

cd ..
cd personal-blog
git add -f public
git commit -m "Publish site %formatted_date%"
git subtree push --prefix public origin gh-pages
pause
```
# 免责声明

- **脚本仅供学习参考**：本文中分享的自动化脚本仅供个人学习和参考使用，不保证适用于所有环境或符合所有公司的规范和要求。
- **使用风险自负**：在使用本文中的脚本时，请确保您已充分了解其功能和潜在风险。如果您在公司环境中使用该脚本，请务必根据公司的相关规定和要求进行修改和调整。因使用该脚本导致的任何问题或损失，作者概不负责。
- **遵守公司规定**：如果您在公司环境中使用该脚本，请务必遵守公司的相关规定和要求。例如，提交信息的格式、仓库的命名规范等。因未遵守公司规定而导致的任何问题或纠纷，作者概不负责。
- **自行测试和验证**：在将该脚本应用于实际工作环境之前，请务必在测试环境中进行充分的测试和验证，以确保其符合您的需求和环境要求。