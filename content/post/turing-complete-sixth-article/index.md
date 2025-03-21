+++
date = '2025-02-21T09:15:00+08:00'
draft = false
title = '图灵完备游戏攻略6'
image = "/image/Turing-Complete-Logo.png"
description = "介绍了一些我的后续构建的64bit计算机的一些思路以及是指令集"
math = true
categories = [
    "steamgame"
]
+++

# 图灵完备部分游戏攻略

## 函数

后面再更新了，目前觉得架构太差后面改了64位了再调了

## 机器赛跑

![要求](robot-run-race-request.png)

有一说一，改动架构之前，我使用了通过最简陋的代码通过了，后续再改动吧

![最简陋的完成方式](robot-run-race-finish-ugly.png)





## 我开始搭的64位计算机

虽然这并不是游戏内关卡，我也好几天没更新了，改架构，我想着嘛，要改就改64位的，方便以后加东西，于是就有了下面的一些

![16个64位的寄存器组](16reg.png)
![细部处理](16reg-2.png)

![64位内存](ram.png)
![64位的栈](stack.png)

![计算单元，把所有的计算相关的元件包含进去了](calc-core.png)
![逻辑单元，包含了常用的所有逻辑元件](logic-core.png)

![指令集限制](introduction-set.png)

看了一下指令集，好像8位就没再变化过了，那只能写在别处了，怪不方便的，以及是，介绍一下我现在的新的寻址方案，如下，利用判定寻址信号线的数据是否跟常数相等来决定这位是否要输出，
也就是换个说法就是，我可以通过这个常数决定它的地址位

![新的寻址方案](addressing-scheme.png)

这是运算器的指令集，我打算直接前256位都用来放运算的，虽然不知道会不会够
```
1 add 2 sub 3 times 4 div 5 or 6 nor 7 nand 8 and 9 xor 10 xnor 11 not 12 ashr 13 ror 14 rol 15 shr 16 shl
```
eq表示equal，相等，ns表示no-sign，无符号状态，s表示sign，有符号的
```
17 eq 18 lessns 19 lesseqns 20 greater_ns 21 greatereq_ns 22 less_s 23 lesseq_s 24 greater_s 25 greatereq_s 26 always 27 notime 38 noteq
```
这是指令前256位现已分配的，然后是256位之后的，我打算把第九第十位分配成参数1和参数2的立即数指令，这个必须独立在其他指令之外的，

因为也玩到这了，看了一下别人的架构，有点羡慕，我好像有点思维定式了，其实pop push那些命令只指定少数的参数的，亦或者说是内存的读写，没必要输出4位空一位，以及，对上面的一些内容修改如下：

![改动后的寄存器](reg_new_args_2.png)
![改动后的栈](stack_new.png)

栈前面忘记pop的时候弹出值了，重新修改了一下如上，因为第三位和第四位已经不需要再用了，也就是说，我可以临时修改步进值来节省程序位，现在直接写了一个可临时调整的步进器

![步进数](count-template-step.png)

因为图灵完备游戏中没处列，我先把基础语法在这写一下然后在游戏中对照这个优化吧

```
28-mov [reg|io] [reg|io](result)
29-jmp [label]
default-add+[im|io] [reg|io] [reg|io] [result-reg](result)
30-pop [reg|io](result)
31-push+[im] [reg|num|io]
32-call [label]
33-ret
34-set [reg](result) [num]
35-write_ram+[index_or_not|0] [reg|io] #可以是0是默认写入1是加入索引,见36
36-write_ram+[index_or_not|1] [reg|io] [index]
37-get_ram [reg](index) [reg](result)
default-not [reg] [reg]
38-noteq
读写地址
1-16 reg
17 count
18 io   
```

其中逻辑代码和运算代码已经占用了27位，以及是第九位，第十位，也就是256和512位分别对应是立即数模式

![index为0](ram-4input.png)
![index为1](ram-4input-index1.png)

之前一直不知道内存这四个输入干什么用的，直到测试了64位的，刚刚我一脸懵，为啥64位+256一下子就没了，直到意识到，刚好四倍，以及是其他口输入跳到右上画框的地方去了，
哦，我就懂了，也就是说，数据位宽4倍的状态下，4位可以同时写入，并且这是一个字节，算是意外收获吧

![更新之后的RAM](ram-new.png)

![2-24日更新的增加的机器码指令功能](some-machine-code.png)
![bug](bug-in-turing-complete.png)
![img.png](release-for-bug.png)

最后修了几个小bug

因为noteq忘了现在在上面作为第38位补上

------------
# 新架构
20250226更新

更新一下我的计算机架构

![思维导图](mind-map.png)

因为get_ram的读写问题，我准备把指令划区了，目前打算1-64划给add等计算指令，填不满的空着，以及64到128的给逻辑指令，129后面则是其他，例如内存的读写指令
即get_ram以及其他指令等，以下介绍各种模块

## calc 计算模块
**语法** 
```
except not
[command]|[command+im] [reg] [reg] [reg](result)
not 
not|not+im [reg] [reg]
```
## **机器码指令对照表**
```
1 add 2 sub 3 times 4 div 5 or 6 nor 7 nand 8 and 9 xor 10 xnor  11 ashr 12 ror 13 rol 14 shr 15 shl 63 not
```
语法
```
非not
[command]|[command+im] [reg] [reg] [reg](result)
not
not|im [reg] [reg](result)
```

特意把not放到末尾是因为它只要占用3个程序位即可,其他在process-center可以一起包起来，因为语法都是一样的

## logic 逻辑模块
**语法** 
```
[command]|[command+im] [reg] [reg] [num](count)
```
**机器码指令对照表**
```
64 eq 65 noteq 66 lessns 67 lesseqns 68 greater_ns 69 greatereq_ns 70 less_s 71 lesseq_s 72 greater_s 73 greatereq_s 74 always 75 notime
```

## 其他指令及其语法
```
128-mov [reg|io] [reg|io](result)
129-jmp [label](count)
default-add+[im|io] [reg|io] [reg|io] [result-reg](result)
130-pop [reg|io](result)
131-push+[im] [reg|num|io]
132-call [label]
133-ret
134-set [reg](result) [num]
135-write_ram+[index_or_not|1] [reg|io] [reg](reg的值作为索引) #可以是0是默认写入1是加入索引,见36
136-write_ram+[index_or_not|0] [reg|io] 
137-write_ram+[index_or_not|1] [reg|io] [index]
138-get_ram [reg](index) [reg](result)
139-get_ram+1 [num] [reg](result)
140-function 
141-end 
```
## 地址表
```
1-16 reg
17 count
18 io
```

新增关键词
如果执行遇到function，直接跳到funend(未实现)
```
function
label [function_name]

pass

return
funend
```

以及，调试时可以先把调试值改了，然后观察自己需要什么输出，避免迷茫

## 内存控制模式
```
1 read
2 write by reg write_reg [reg|io]
3 write by index  write_reg [reg|io] [reg|io]
```

[//]: # (修改索引输出端口后验证到131处)