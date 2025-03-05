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
同[图灵完备alpha篇攻略2#BIG SWITCH](https://adeepblue.github.io/p/%E5%9B%BE%E7%81%B5%E5%AE%8C%E5%A4%87alpha%E7%89%88%E6%94%BB%E7%95%A52/#big-switch)

## SIGNED NEGATOR

这关需要反转数字的符号，这个，跟按位取反很像，但不完全一样，比如说0，实际就是$0b00000000$,反转之后变成$0b11111111$,很明显，目标要是$0b00000000$,
需要加1，规定输入为a
$$
a=-a_7\cdot2^7+\sum_{0}^{6} {a_i\cdot2^i}  
$$

或

$$
a=-a_7\cdot2^7+a_6\cdot2^6+...+a_0\cdot2^0
$$

则

$$
nota = -(-a_7\cdot2^7+\sum_{0}^{6} {a_i\cdot2^i}) = a_7\cdot2^7-\sum_{0}^{6} {a_i\cdot2^i}
$$

这里并不能直接用-a直接套入取反，因为$nota$不等于$-a$，从$a = 0$就可以看到了，此时的a按位取反等于$0b11111111$,等于-1，但$-a$依旧等于0,此时通过$a+(-a) = 0$这个等式来推得-a，
因为-a也是需要占用数字位的，所以最好的选择就是，要满足刚好溢出的条件，要两数相加等于256，也就是$0b00000000$，然后进位信号亮起，已知$nota+a = 0b11111111$
$nota+a+1 = 0b00000000$,则

$$
-a=nota+1
$$

所以，相反数就是nota+1,解法如下

![解法](signed-negator-solve.png)

## THE BUS

![img.png](the-bus-solve.png)

## SAVING GRACEFULLY

![要求](saving-gracefully.png)

优雅存储

观察下面写入和输出内容，不难发现，它希望内部存在一个线路，它希望存储一个数，如果这一刻的写入开关被打开的话，那就按照写入的内容改变这个存储的数，利用开关，可以实现如下的行为，用两个开关，一个是在0的时候发生作用，一个在1的时候发生作用，
来改变对下一刻输入的影响，其中这时候的输入还得等到下一刻，所以最后输出还必须加上一个延迟线

![解法](saving-gracefully-solve.png)

## SAVING BYTES

![img.png](saving-bytes-solve.png)

等于是把8个寄存器封装起来，然后最后一位控制是否输出，即，如上

## 1 BIT DECODER

![img.png](1-bit-decoder-solve.png)

## 2 BIT DECODER

![img.png](2-bit-decoder-solve.png)

这里只能是使用and的条件严格限制了

## 3BIT DECODER

![img.png](3-bit-decoder-solve.png)
同上

## LETTER BOX

![img.png](litter-box-solve.png)

这个解法比较麻烦，我也摸索了好一会，有之前的版本的，布线布的很乱，也很麻烦，后面想到了4路一位开关，这个可以代替两路开关，不过，四路的地方，得控制输入也得控制输出，
于是就有了控制电路直接连带输出一起控制了，开关输入的时候控制的写入信号，是否就哪怕开关在也没关系了，打开就是不写入，以及只需要额外增加一个输出的控制开关即可，貌似现在版本的图灵完备默认的输出区分开了0输出和不输出，虽然现实中没区别
