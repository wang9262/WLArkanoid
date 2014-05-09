###Introduction
---
This is a Arkanoid-liked Game which is written in Verilog HDL.The game has 4 levels,the 1st is the common one which has 18 blocks,and when the ball hits the block,the score will add 1 point automatically;the 2nd has 4 blocks,each time the ball hits the block, the block will changes its color,and after 4 times,it will disappear;the 3rd is PVP mode(player vs player),there are two boards which present two players,when the ball go beyond the board's scope,the player fail;the 4th is PVC mode(Player vs computer),this is similar to the 3rd one.

Additionally,this project is based on FPGA development Board DE0 board,and compiled in Quartus II 9.1. 

It's a curriculum design of mine.It mainly contains these files that include the key code.They are as follows. 
####1.vga_d.v
This is the top file,which calls all the blockette,include ps2_top(designed for ps/2 keyboard),VGA_sm(designed for scanning),VGA_display(to display all the things that shoud be displayed).By the way,the files rom1.v,rom1_bb.v are generated automatically.
####2.VGA_sm.v
This file is mainly used for the scanning,and achieve the time series of the horizonal and vertical signals.
####3.ps2_top.v
The keyboard control the ball in VGA_display.v.
####4.VGA_display.v
This implements all the logic of the game and shows how to load bmp files.
####Some More Improvements
Because of the little time,we completed this Arkanoid-liked game summarily,and many of modules are not implemented, including playing sounds,enter the next level automatically when all the blocks disappear and so on.

If you have some problems during using this,please contact me,and my [Email](http://Vong9262@gmail.com)

###简介
这是一个打砖块的游戏,是基于Verilog的,是我的一个课设作业.游戏分为四关,第一关是普通模式;第二关为变色模式,一共四块砖,每碰一下,砖块颜色改变一次,改变四次颜色后自动消失;第三关为人人对战模式;第四关为人机对战模式.

这个游戏是基于FPGA DE0开发板的,在QuartusII 9.1 环境下编译的.

工程中,包含核心代码的主体文件大致如下.
####1.vga_d.v
顶层模块,主要是其他子模块的调用,以及将晶振产生的50MHz时钟分频,分成两种,具体见代码.
####2.VGA_sm.v
主要实现行场信号的同步,以及行场扫描时的计数,方便后面填充颜色做处理.
####3.ps2_top.v
PS2键盘模块的实现,用来控制板子的移动.
####4.VGA_display.v
实现整个图形的显示,以及游戏逻辑的实现.
####不足和期待你的改进
有加入发声模块,但是没有发出声音,不知道哪里有问题,在砖块被打光后不会自动进入下一关.还有就是代码的规范化,由于这个工程是三个人合作的,代码风格完全不一样,另外两名队友由于缺乏代码规范化的经验,所以整个代码看起来有点乱,现在也懒于整理了.

如果你还有其他疑问,或在运用本文件时遇到问题,请和我联系.我的[邮箱](http://Vong9262@gmail.com)