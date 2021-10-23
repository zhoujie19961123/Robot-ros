% 产生传感器噪声输出等
clc;
clear;
close all;


v=8;  %方差是8
t=0:0.01:9.99;

m=2*t+20;
s=m+sqrt(v)*randn(1,1000);


 plot(t,s);
 xlabel('采样时刻')
 ylabel('测量数据')

 Hk=[t;ones(1,1000)]'; %最小二乘法估计一次多项式的参数
 estim = inv(Hk'*Hk)*Hk'*s'  %inv是逆矩阵
 
 %线性最小二乘递推估计
 
 ea=[0;0]; % 设置估计的初值
 
% M=diag(1)*1000; 其实这个式子就是1000，和矩阵相加的话，每个元素都要加上这个数字
 M=eye(2)*1000; %和上式子副对角线有差别
 
 estimate=[];  %储存计算的结果，保存为向量形式
 w=0.5;       %设置权值 
 
 for i=1:1000
     h=[t(i) 1];  %可以参照原始曲线的状态方程的定义
     
     M=inv(inv(M)+h'*w*h);     %迭代的公式，两个
     ea=ea+M*h'*w*(s(i)-h*ea);
     
     estimate=[estimate,ea];    %保存计算结果
 end
 
 plot(estimate(1,:));
 figure;
 plot(estimate(2,:));
 

 