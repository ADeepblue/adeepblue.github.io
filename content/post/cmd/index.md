+++
date = '2025-02-04T22:34:00+08:00'
draft = false
title = 'Cmd命令笔记（会时不时更新）'
description = "介绍一些基于cmd的脚本基础用法，也当作自己的笔记"
image = "luca-bravo-alS7ewQ41M8-unsplash.jpg"
+++

# mkdir
起初我以为是用斜杠/来实现分割目录，结果后面发现是反斜杠，
很多地方搞来搞去的很容易搞混搞不清

`mkdir .\a\b\c\d`

基于当前目录下创建 ~.\a\b\c\d的目录

同样的文件分割方式，创建文件可以用touch函数
`touch .\a\b\c\d\e.txt`