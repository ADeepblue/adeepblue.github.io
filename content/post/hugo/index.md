+++
date = '2025-02-04T22:34:00+08:00'
draft = false
title = 'Hugo初始化网站笔记'
description = "hugo初始化记录"
image = "hudai-gayiran-3Od_VKcDEAA-unsplash.jpg"
+++

# Hugo笔记

首先是先下载hugo,我的话因为后面可能命令行会比较常用，所以手动把它添加进了环境变量 path里面
也是有这个步骤才可以下面直接hugo命令直接用了

前前后后也搞了不少时间，万一以后文件丢失了可以来这边参考我自己写的hugo笔记
建站命令

`hugo new site personal-blog`

此处personal-blog可替换文件夹名字，会自动新建文件夹然后在该文件夹下放初始化的内容，新建完网站本
身之后就可以开始写md文件了，比如此处我新建了`hugo/hugo-init.md`文件，命令如下

`hugo new hugo/hugo-init.md`

命令行返回为

```
E:\personal-blog\personal-blog>hugo new git/git-init.md
Content "E:\\personal-blog\\personal-blog\\content\\git\\git-init.md" created
```

再有就是自带的文件头，
```
+++
date = '2025-02-04T21:10:15+08:00'
draft = false
title = 'Test'
+++
```
原本`draft`中的值是true,需要改成false才能进行页面发布
，可能是因为类似审核的过程？方便管理确认？亦或者说不想显示
某篇文章先用这种方式隐藏起来？虽然也只是我的猜测而已罢了
```
# 文章标题

这是你的主要内容部分。你可以在这里添加文本、列表、引用、图像等。

## 子标题

### 列表示例

- 第一项
- 第二项
- 第三项

### 引用示例

> 这是一个引用的例子。

### 图片示例

![图片描述](图片链接)

### 代码示例

`ssh git@github.com`
```
以及是，`content`目录下必须包含_index.md文件，不然会不显
示主页，这就是主页， 命令可以以下方法实现

`hugo new _index.md`

然后我目前打算添加的代码，（有变动会更改）
```
---
menu:
    main:
        name: 主页
        weight: -100
        params:
            icon: home
---
```
目前git处文章不显示，未知原因，起初发现`draft=true`没修改，但目前不清楚因为什么导致不显示

总觉得hugo挺多bug的，之前有404过不少时间，调试了很久重新开始hugo new site personal-blog 
然后重建git仓库，弄了许久没弄好，现在又出现`hugo new post/cmd/index.md`没法创建
疑似可能是因为hugo server正在启动无法使用new命令吧

写的文markdown文件如果不是index.md的话会出现头字段(front matter)image字段图片加载失败的问题

也奇怪，一开始没搞定背景图片，这次一遍过了，下面这条命令是创建文件夹的命令，在网站根目录打开cmd运行

`md .\assets\background`

然后在这个文件夹内放背景图片后，运行以下命令创建

```
md .\layouts\partials\footer
touch .\layouts\partials\footer\custom.html
```
并将以下代码直接放入上面新建的custom.html内部
```
<style>
  body {
    background: url({{ (resources.Get "background/背景图片名").Permalink }}) no-repeat center top;
    background-size: cover;
    background-attachment: fixed;
  }
</style>
```

此处感谢`莱特雷-letere`大佬的博客指引https://letere-gzj.github.io/hugo-stack/p/hugo/custom-background/