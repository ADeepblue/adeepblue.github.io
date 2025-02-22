+++
date = '2025-02-13T16:21:04+08:00'
draft = false
title = '图灵完备游戏攻略3'
image = "/image/Turing-Complete-Logo.png"
description = "解决了包含宽指令、一把线，像挂面、操作码、立即数、条件判断的破关思路"
categories = [
    "steamgame"
]
+++

# 图灵完备部分游戏攻略
## 宽指令

![要求](Wide-instruction.png)

要求偶数刻存储，奇数刻一次输出存储的一个值和本身程序的值，也就是说，我需要调用一个寄存器，然后用一个分线器，查看一下最低位的1的值就知道现在是奇数偶数了，
偶数时刻，比如说0，也就是说1位处于低电平的时候写入寄存器，也就是需要套一个非门，因为程序的输出口还有直接输出到输出的功能，所以最好给程序输出口套一个八位开关，没有低电平的时候直接不输出值，
这样偶数刻的操作就结束了，再有奇数刻要输出两个数的值，也就是说，1位高电平亮起，同时，控制寄存器一位和程序一位分别向输出口输出即可，分别套一个八位开关
如下：

![解法](Wide-instruction-solve.png)

## 一把线，像挂面
![要求说明1](new-architecture-require-1.png)
![要求说明2](new-architecture-require-2.png)
![要求说明3](new-architecture-require-3.png)

![要求说明4](new-architecture-require-4.png)
![要求说明5](new-architecture-require-5.png)


按照它上面说的，先将计数器步进设置为4

![说明](set-step.png)

以及是根据要求说明2里的图，后三个都是操作地址，也就是说，后三个全部需要用到分线装置控制到哪一位，这就可能要点布置

![改造后的8位数据8选1元件](8bit-8-select-1-8bit.png)

首先如上改造了一下以前的八选一的数据元器件，改成8bit好方便输入

![布线](8bit-8-select-1-8bit-in-main-1.png)
![补一下ALU的描述](describe-ALU.png)

后悔没补上ALU的描述，因为刚才报错我以为要求说明4里的add确实是0输入ALU里面的0了，结果不是，ADD在ALU里对应的控制码是4，那我就补一下，因为现在反正也是临时的，
不确定后面的控制码要求是什么样的，毕竟0变成add了，那有可能后面ALU也得改，既然现在它要求只是add那我直接就控制码始终是4输入罢，后面要改了再说

![第一版临时的布线方案](temp-LEG-main-1.png)

第一版布线方案用了之后，发现一旦输出是0了，就输入不到寄存器里了，意识到了这么个问题，但想想，好像是因为本身的问题，因为上面一版布线我直接就是为了省控制位的线，
直接用了判断输出是否是0来决定是否要写入寄存器，但明显这是个失误，得补上控制线

![最终方案](LEG-main-1.png)
![改动处](LEG-solve-1.png)

有改动的地方如上，也就是操作码强制被指定4，断开初始操作码，以及是新增控制码

## 操作码

![要求](LEG-control-code.png)

只能说，果然不出所料了，控制码有变更了，那也就是意味着，ALU我有条件的话重构一个会好一些了，然后按照对应的控制码调整自定义ALU的位置即可

![定制的ALU元件](custom-LEG-ALU.png)

![完成](LEG-main-2.png)

最终只要把上述的线给连回去就行了，删掉原来的8bit常数

## 立即数

![新版立即数](new-immediate.png)

判断是否是立即数模式，我又想造元件了，毕竟，咋说呢，目前8bit后两位是用来判断立即数的，然后前三位是用来判断运算的，估计后面还有加的，不如设计一个元件，
输出对应立即数模式和计算模式，然后输出对应的东西，这样会快一点，直接放在整个LEG框架空间内就显得太拥挤了，曾经就是输出一位判断码，这次直接输出的是所有控制位，感觉也不错

![过去的解码](last-DEC.png)
![现在的分流](LEG-DEC.png)

以下是目前的布局方案，其中左边处通过解码，上面的三位直接通过新的分流方案通过三位数的传递接替了上面的原布线，而下面的两位控制立即数模式，也就是右边做出的改动，
输出的两位是两位控制码，也就是输出的数采用原数还是从寄存器里选出来的数，二选一，所以用了八位数据选择器，这样就能运行的通了

![现在的布局](LEG-main-3.png)

## 条件判断


现在可以自定义指令集了，顺带改一改吧就，刚差点没找到怎么移动描述的位置，抓住AND右边的引脚拉到最边上再拖动左边的引脚即可

![自定义指令集](../turing-complete-fourth-article/custom-introduction-set.png)

------------------------

下一篇博文见,下一篇链接[图灵完备游戏攻略4](https://adeepblue.github.io/p/%E5%9B%BE%E7%81%B5%E5%AE%8C%E5%A4%87%E6%B8%B8%E6%88%8F%E6%94%BB%E7%95%A54/)