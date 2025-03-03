+++
date = '2025-03-03T15:32:57+08:00'
draft = false
title = '图灵完备alpha版攻略3'
image = "/image/Turing-Complete-Logo.png"
math = true
categories = [
    "turing complete alpha"
]
+++

# 图灵完备alpha篇攻略3

## BYTE NAND

![要求1](byte-nand.png)
![要求2](byte-nand-2.png)

虽然但是，它好像写错了，标题写着nand门，也就是与非门，要求里也是写着与非门，但中文翻译处写着或门，按与非门来吧，也就是逐位处理，如下

![img.png](byte-nand-solve.png)

## BYTE NOT

![img.png](byte-not-solve.png)

简单的不解释了

## ADDING BYTES

![要求](adding-bytes.png)

8bit的加法，先按最低位使用加法，，如果有进位那就给下一位的提供进位信号，然后按对应的位输入对应的位置，实现如下

![解法](adding-bytes-solve.png)

## MULTIPLEXER

![解法](multiplexer-solve.png)
同