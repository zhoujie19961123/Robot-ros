%% %%%%%%%%%%%%%%%%%%%%%

%逆变器的频率50HZ，幅值为1000V，叠加了方差为30的正态分布随机噪声
%用循环结构编制三点线性滑动平均的程序

%% %%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
t=0:0.001:20;
n=length(t);

y=1000*sin(t)+30*randn(1,n);

ya(1)=y(1);  %起点

for i=2:n-1
    ya(i)=sum(y(i-1:i+1))/3;  %相邻三个相加求和在平均
end

ya(n)=y(n);  %终点

plot(t,y,t,ya);
grid on;
legend('滤波前','滤波后');
title('滤波前后对比');