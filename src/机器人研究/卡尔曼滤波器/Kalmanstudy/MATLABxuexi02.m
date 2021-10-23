%多项式插值函数
%method='nearst'这种将结果设置成最近的数据点的值
%method='linear' 将两个点之间连成直线
%method='spline' 三次样条插值
%method='cubic'  立方插值
%在离散数据的基础上补插连续函数，使得这条连续曲线通过全部给定的离散数据点。
%规定好x的间隔，由所用的method计算函数值让曲线平滑地通过原先的所有数据点

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;    %清屏
clear all;   %清除工作区，避免上次运行结果影响
close all;    %关闭所有窗口

ys=10*rand(1,15);  %产生1行15列的随机数

xs=0:length(ys)-1;   %已有的样本点,length是行列之中的最大值
x=0:0.1:length(ys)-1;  %新的插值样本点

y1=interp1(xs,ys,x,'nearst');  %不同的插值方法产生新的样本点
y2=interp1(xs,ys,x,'linear');  
y3=interp1(xs,ys,x,'spline');  %三次样条插值
y4=interp1(xs,ys,x,'pchip');   %旧版的是cubic

figure;
plot(x,y1,'.','color','b','MarkerSize',10);  %画出新的样本点
hold on;

plot(xs,ys,'ro',x,y1,x,y2,x,y3,x,y4);    %画图

legend('spline插值样本点','原样本点','nearst','linear','spline','pchip');  %图例

title('多项式插值举例');    %标题










%[xs,ys,z]=peaks(10);
%为了方便测试立体绘图，MATLAB提供了一个peaks函数，
%可产生一个凹凸有致的曲面，包含了三个局部极大点及三个局部极小点
%[xi,yi]=meshgrid(0:.1:15,min(ys):0.1:max(ys));
%zi=interp2(xs,ys,z,xi,yi);
%figure(2);

%mesh(xi,yi,zi),shading flat,title('二维插值');