+++
date = '2025-02-28T11:08:48+08:00'
draft = false
title = '图灵完备alpha版攻略1'
image = "/image/Turing-Complete-Logo.png"
math = true
categories = [
    "turing complete alpha"
]
+++

# 一些说明
图灵完备更新了版本，疑似修复了我图灵完备攻略6的bug，但是以前的存档不能用了（可能类似于内部数据结构变动），也正好，我打算借着这个机会重新玩一下以前的关卡，有一些在现在的视角有更优雅更好的解法，
就当是补以前没写博客时的攻略了,虽然躲不掉bug也挺难受的

![一些语言bug](some-language-bug.png)

# 图灵完备alpha篇攻略

## NAND门 (NAND GATE)

![说明](nand-solve.png)

点击输入观察输出，改成对应的类型即可，最终结果是，除了输入1和2都是高电平的时候低电平输出

## NOT GATE

![说明](not-gate.png)

现在我们手里的只有一个NAND门，但是，由于nand门的特性，我们只要把nand的两个输入绑定成一样即可，4个不同的输入就会坍缩成2输入，也就是0和1

![](not-solve.png)

## AND GATE

### 解释一

观察NAND门，它信号也只有两个输入都是1的时候才会为0，这是一个特殊的突变点，and门也有类似的结构，但是突变点在两个输入都是1的时候，结果为1，那么，
现在已经有not门可以取反了，我就可以用not门直接反转输出结果，在nand的末尾加上not门就是and门了

