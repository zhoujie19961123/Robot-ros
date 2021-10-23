%%%%%%%%%%%%%%%%%%%%%
% 二阶RLC电路伯德图/奈奎斯特图分析
%
% H(s)=(1/LC)/(s^2+sR/L+1/LC)
%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;

R1=10;L=1000e-6;C=100e-6;
H1=tf(1/(L*C),[1,1/(R1/L),1/(L*C)]);

R2=100;
H2=tf(1/(L*C),[1,1/(R2/L),1/(L*C)]);

R3=1000;L=1000e-6;C=100e-6;
H3=tf(1/(L*C),[1,1/(R3/L),1/(L*C)]);

figure(1);
bode(H1,H2,H3);grid on;   %伯德图
legend('R=10','R=100','R=1000');

figure(2)
nyquist(H1);  %奈奎斯特图分析
figure(3);
rlocus(H1);
figure(4);

t=0:0.1:10;
lsim(H1,sin(t),t);grid on;title('正弦激励响应图');
%lsim(SYS, u) 计算/绘制系统SYS对输入向量u的响应 