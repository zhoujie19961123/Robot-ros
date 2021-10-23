% matlab自带的多项式拟合的命令函数

clc;         %清屏
clear all;   %清除工作区，避免上次运行结果影响
close all;   %关闭所有窗口

x=0:0.1:2*pi;   %取了63个点

y=sin(x)+0.5*rand(size(x));  %随机rand产生大小为size（x）的矩阵
                             %rand的范围是在0~1之间，另有randn可以产生正态分布的-1~1之间的随机值
plot(x,y,'b*');     %用蓝色的*点画出这条随机曲线
hold on; 

for i=1:5
    
P=polyfit(x,y,i)
%polyfit函数是matlab中用于进行曲线拟合的一个函数。其数学基础是最小二乘法曲线拟合原理
%x是数据点横坐标，y是纵坐标，i是阶数

y1=polyval(P,x);  %求出多项式的值
plot(x,y1);       %画出新的曲线

hold on
title('函数拟合');  %标题

junfangcha=sum((y1-y).^2)/length(x);   %计算均方差

fprintf('%d次的均方差为%d\n',i,junfangcha); %命令窗口展示，类似C语言的用法

end
%图例
legend(' ','一次函数曲线','二次函数曲线','三次函数曲线','四次函数曲线','五次函数曲线');