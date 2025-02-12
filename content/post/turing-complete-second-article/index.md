+++
date = '2025-02-12T15:23:34+08:00'
draft = false
title = '图灵完备游戏攻略2'
description = "解决了异或、八位常数，相等，8位异或、无符号小于、有符号小于这些八位运算符"
image = "/image/Turing-Complete-Logo.png"
categories = [
    "steamgame"
]
+++
# 图灵完备部分游戏攻略2
## 异或
目标
![实现异或](computer-command-XOR.png)
虽然它说的是八位数按位进行执行操作的异或，因为已经实现了多个以八位通道进行的计算，所以，某种程度上它可以通过翻看以前的一位异或来参考解法，当时我为了完成成就也搞定了另一种解法，虽然是我蒙出来的

![4个NAND实现](4-Nand-solve-XOR.png)
![正常手段实现](XOR-default-solve.png)

### 第一种解法
因为四个NAND实现的元器件实在是太难存储变量了，通过上一篇图灵完备攻略即可得知，额外的只有两个存储位，因为现在不需要立即数模式，所以reg0也可以当作紧急备用，也就是说，满打满算三个存储位，
先读取两个数分别到reg4和reg5，然后计算两数的按位nand的值到reg0（以前从没用过），然后根据后面计算结果覆盖reg4和reg5，因为，毕竟输入的两个数终究也只是两个中间变量，不必要永久存储，实现如下

```
# copy two num to reg4 and reg5
in_to_reg4
in_to_reg5

# have a nand operation
reg4_to_reg1
reg5_to_reg2
nand

# save nand two num to reg0
reg3_to_reg0

# do another two nand to instead the num in reg4 and reg5, reg4's num is in the reg1  
reg0_to_reg2
nand
reg3_to_reg4

# do another reg5
reg5_to_reg1
nand
reg3_to_reg5

# now nand reg4 and reg5
reg4_to_reg1
reg5_to_reg2
nand

reg3_to_out
```

### 第二种解法

因为不满足于一种写法，所以我现在来实现第二种，其中Nor的指令我去加一个，还没加入汇编指令集

![加入指令集](Nor-introduction-set.png)

如果说上面那种属于是额外生成一个中间变量然后参与跟起初的两个数的运算的话，现在另一种正常的方法看电路就知道，因为再也不需要调用到前面的变量了，直接可以执行覆盖操作，可以说是
先把in的读取到reg1和reg2进行预备的运算，然后可以直接复制中间变量到reg4和reg5，至于输入，用完就可以丢了，

不过唯一要研究一下的就是，怎么对一个数进行按位的取反就是了，虽然这在单个电路里是个简单的事，但毕竟已经有程序了，肯定还是用现成的东西去实现，以及，立即数模式虽然没办法生成255这个值（到64位以上就已经是控制码了）
但是要生成可以通过两个运算数都是0的情况下进行nand运算即可得到255

![算数引擎](Arithmetic-engine.png)

多看两眼算数引擎，好像可以直接拿那边的八位的not来用感觉？先有一路经过nand的数进行了一下八路not运算，到or这，也就是只要保持另一路是0就可以保证or直接输出单路了
那么也就是对应过来另一路输出就是需要是255，怎么得来就可以通过reg0原本就没使用过输出到reg1和reg2进行nand或者nor运算得到，思路确定了，也就只剩下编写代码了

```
# copy two num to reg4 and reg5
in_to_reg1
in_to_reg2

# do first operation
nor
reg3_to_reg4

# do second operation
nand
reg3_to_reg5

# set 0 to reg1 and reg2 to get 255
reg0_to_reg1
reg0_to_reg2
nand
# set 255 num to reg0
reg3_to_reg0

# Set two numbers that will be operated on
reg3_to_reg1
reg5_to_reg2
nand
reg3_to_reg5

# do OR operation to the num in reg4 and reg5
reg4_to_reg1
reg5_to_reg2
or

# final operation
reg3_to_reg1
reg0_to_reg2
nand
reg3_to_out
```

最终因为not麻烦一点依旧是用了4个nand计算方法吧，最后依旧也是跟上面一样，调用了立即数的出口reg0存储了255来直接使用nand运算打成not的效果，怪麻烦的。

## 八位常数
![要求](8-bit-constant.png)

这，好像只要指定八位集线器然后用高电平直接控制对应位置就好了，低电平都可以不放了
![解法](8-bit-constant-solve.png)

## 相等
![要求](equal-for-8-bit.png)

说起相等，前面这一圈下来，好像确实没有涉及跟相等有关的布尔值输出来着，前面也有想要这样判断的并没有
也有两种思路，一种是先用sub减法一样的电路把两个8位数相减，然后确认出来的值是不是0就行了，也就是or8路线路，检查是否是0就行了，第二种是直接八位分线器出来然后一个一个同或比较，最后and8位输出

### 思路1
![8位两路相减后判断](equal-for-8-bit-1-solution.png)

### 思路2
![分别判断每一位是否相等](equal-for-8-bit-2-solution.png)

## 8位异或

![要求](8-bit-XOR.png)

因为8bit已经有了对应的上面对应只有一位情况的所有运算器件，
所以只要根据上面一位异或换成8bit的版本即可

![所有8位运算元器件](8-bit-components.png)

![解法1](8-bit-XOR-1-solution.png)
![解法2](8-bit-XOR-2-solution.png)

## 无符号小于

![条件](not-sign-smaller-than.png)
第一反应是直接相减后判断大小，a<b,也就是证明b-a>0，那也就是说，使用两个相减判断符号就行了，吗？一旦a作为第一位输入是8，作为被减数，然后先取一个反，
但按位取反一旦变成无符号整数，那就已经不一定奏效了，一位一位比较也比较麻烦，其中无符号状态下的取反，b-a实际上成了b+(255-a),也就是255+b-a，如果b-a
大于0，那么255加上b-a必定大于0，也就是说，如果进位信号有显示，那么b就是大于a的，也就是输出高电平，刚好跟进位信号对上了，也不用取反了

![解法](no-sign-smaller-than-solve.png)

## 有符号小于

![条件](sign-smaller-than.png)
![相反数](opposite-number.png)

看到这个条件，也就是说，128的地方变成-128了，就要去稍微翻一下相反数的那个元器件了，因为，如果是带符号的，那也就意味着，b-a=b+(-a),而又有相反数等于它本身按位取反之后，
再在加法器上加一得到的，那也就是说，这个加1，我可以当作进位运算，但依旧遇到了点问题，因为，一旦像是如下图这般的，存储溢出了就会失效，进位信号不可用不说，输出直接变成负数，
但最重要的问题在于，这个溢出不好控制，最后一位一旦填上负数之后就不好说了，因为有其他情况也会出现负数

![问题图一](trouble-in-sign-smaller-than.png)
![问题图二](trouble-in-sign-small-than-1.png)


进行一下完整的分析，设定x,y>0,执行操作每次为第二个数减第一个数，其中-(-128+1)为not的输出，上面但实际最后一位第八位是作为负号位的，进到这位属于溢出，但并没有让加法器溢出，

> **1.** 第一个数为-x,第二个数为-y: -(-x+1)-y+1 = x-y，这个数可大于0可小于0，需要判断符号，可能会有进位

> **2.** 第一个数为x,第二个数为-y: -(x+1)-y+1 = -x-y, 必定小于0，但溢出可能大于0，有进位信号

> **3.** 第一个数为-x,第二个数为y : -(-x+1)+y+1 = y+x, 必定大于0，但溢出有可能小于0，无进位信号

> **4.** 第一个数为x,第二个数为y : -(x+1)+y+1 = y-x, 这个数可大于0可小于0，需要判断符号

在那之前，最好先给两者判断一下-128位的信号，至于等于0的情况再考虑,其他小于0的情况可以直接默认不输出，比如case2
其他情况剩下case1和case4

![case3](case3.png)

case1

![case1-1](case1-1.png)
![case1-2](case1-2.png)
![case1-3](case1-3.png)

第一张图，x=128>y = 96,取反之后也更靠近128，而y比x距离128稍远些，边界情况如图三所示，刚好所有值都对应上，也就是说如果x=y,两个加起来刚好进位
但add处等于0
也就是说

> **1.1** 进位信号有，输出信号的**总和**端口等于0 => 两数相等 (总和是个输出端口名)

> **1.2** 进位信号有，输出信号的**总和**端口大于0 => -y>-x，第二个数大于第一个数，需要输出1

> **1.3** 进位信号无 => -y<-x,不需要输出

![case1的最终处理](case1-final.png)
其中直接连入输出了，需要一个开关控制，其中两头直接由两个输入的-128位控制，如果两个数都是高电平才触发上面的，其中中间一位可以开关直接连到case3的输出上，
毕竟开关触发条件也是跟case3一样的，下面-128低电平，上面-128高电平

同理

![case3-1](case3-1.png)
![case3-2](case3-2.png)
![case3-3](case3-3.png)

> **3.2** 进位信号有，**总和**端口等于0 => 两数相等

> **3.1** 进位信号有，输出信号的**总和**端口大于0，y>x 需要输出1

> **1.3** 进位信号无 => -y<-x,不需要输出

仔细一观察，80 48时，除开两处-128信号不同以外，其余部分全部相同，也就是说，现在属于两者同时是1或者0的时候即可成立，那么不用多画了，直接把控制开关的与门替换成同或门即可

![img.png](sign-samller-than-final.png)

下一篇博文见,下一篇链接(还没更新，更新完链接放这里)