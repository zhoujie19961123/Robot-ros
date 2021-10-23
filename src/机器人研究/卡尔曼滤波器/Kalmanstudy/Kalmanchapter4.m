%kalman滤波第四章的学习与应用 
clc;
clear all;
t=0.01:0.01:10;
za=[20+sqrt(2)*randn(500,1);30+sqrt(2)*randn(500,1)];
plot(za);
% 模拟的方法产生具有突变特性的传感器数据，前500个真实值为20，后500个为30

%递推最小二乘法估计，测量方程为z（k）=seita+N(k)
h=1; %测量矩阵
w=0.5; %权值
M=1000;  %初值
ea0=0;
for i=1:1000
    
    M=inv(inv(M)+h'*w*h);
    ea(i)=ea0+M*h'*w*(za(i)-h*ea0);
    ea0=ea(i);
    
end

plot(ea)