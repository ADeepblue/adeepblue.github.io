+++
date = '2025-04-29T22:44:49+08:00'
draft = false
title = '关于cmd传参的一些内容'
description = "写一个启动jupyter notebook脚本的笔记"
image = "CommandLineIcon.png"
categories = [
    "cmd","jupyter notebook"
]

+++

# 写一个启动jupyter notebook脚本的笔记

## 统计计数

看了一下AI给的内容，实在不太行

```batch
if "%#"=="0" (
    echo 未提供参数,在默认目录打开jupyter notebook
    goto V0
)
```

以上内容为kimiAI提供，恐怕也是因为训练数据中，存在着一些错误数据的原因吧，实际如果去调试后就会发现，

 `echo "%#"`只会输出"#"，在AI不可靠的情况下，我去找了一下以前写cmd脚本的记录，其中统计参数是这样的

```batch
set "Count=0"
for %%i in (%*) do (
    set /a Count+=1
)
```

## 条件比较



然后在这样的环境下去对比count和if中的数值，虽然着实有些可笑就是了，到头来统计参数如何还需要自己来for循环累加遍历，其后的调用变量来比较得是这样了，

```batch
if %Count%==0 (
    echo 未提供参数,在默认目录打开jupyter notebook
    goto V0
)
```

## 最终版代码

其中我当时还犯了一个小错误，因为AI给的是双引号，我也双引号变量进去了，发现不对，会报错，然后后面才想起来是用两个百分号来引用的,以及是一旦是数字累加，`%Count%==0`,如果右边是"0"依旧会报错，所以最终版是这样的

```batch
@echo off
SETLOCAL ENABLEEXTENSIONS

set "Count=0"
for %%i in (%*) do (
    set /a Count+=1
)

echo %Count%

if %Count%==0 (
    echo 未提供参数,在默认用户目录打开jupyter notebook
    goto V0
)

if %Count%==1 (
    echo  jupyter notebook 打开于 %1
    goto V1
)

echo 提供了多个参数,仅支持提供一个文件夹路径
goto :error

:V0
cd %userprofile%
jupyter notebook
goto :end

:V1
cd %1
jupyter notebook
goto :end

:error
echo error 
pause


:end
echo 按任意键退出...
```

## 使用方法

直接拖动你想打开的文件夹到这个脚本即可，会在这个文件夹下打开jupyter notebook,切记拖动的是文件夹（主要是我也有点懒得写判断文件夹和文件了，可以在脚本这边新增，但我没这个需求就不写了）拖动会将内容识别为参数传入，然后也就是传参的形式实现切换到对应文件夹打开jupyter notebook

## 一些吐槽？大概

cmd的脚本属实一眼难尽，在我的角度看来，可读性极差，（其中包括各种参数的含义）当时写过一个用来遍历所有文件和文件夹搜索一个文件的脚本，但是，怎么说呢，当时排查错误写的我累死了，当时就想不太想写第二次了，不过考虑到这还是比较简单的一个脚本，倒是随意了，以及这个脚本写了也是为了方便我打开jupyter notebook，有些时候有些科学计算的内容确实还是jupyter notebook写起来会舒服些，用pycharm开python console有点太麻烦了

