%%%%%%%%%%%%%%%%%%%%%%%%

% 功能说明：kalman滤波在一维温度数据测量系统的应用

%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;
N=120 ;    %采样点的个数，时间单位是分钟，相当于进行了120分钟的测量
CON=25;   %室内温度的理论值

% 对状态和测量初始化
Xexpect=CON*ones(1,N);  %期望的温度为恒定的25度
X=zeros(1,N);           %房间各个时刻的温度真实值
Xkf=zeros(1,N);         %kalman滤波的估计值
Z=zeros(1,N);           %温度计测量值
P=zeros(1,N);           %估计误差矩阵，即协方差

% 赋初值
X(1)=25.1; %设置初始的房间温度
P(1)=0.01;
Z(1)=24.9;
Xkf(1)=24.9;  %初始测量值为24.9，同时也作为初始估计值

% 噪声
Q=0.01;
R=0.25;    %可以从说明书上得知温度计的方差大小
W=sqrt(Q)*randn(1,N); %过程噪声的大小模拟
V=sqrt(R)*randn(1,N); %测量值噪声

% 系统矩阵设置
F=1;    %状态转移矩阵
G=1;    %噪声驱动矩阵
H=1;    %观测矩阵
I=eye(1);  %因为系统状态是一维的

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 模拟房间的温度和测量过程并滤波

for k=2:N
    
    %第一步：随着时间的推移，房间温度的真实值在不断变化
    X(k)=F*X(k-1)+G*W(k-1);  %其实就是复现了状态方程
    
    %第二步：随着时间的推移获得实时的测量数据，不断逼近真实值
    Z(k)=H*X(k)+V(k);
    
    %第三步：Kalman滤波，代入公式
    X_pre=F*Xkf(k-1);              %状态预测
    P_pre=F*P(k-1)*F'+Q;           %协方差预测
    Kg=P_pre*H'*inv(H*P_pre*H'+R);  %计算卡尔曼增益
    e=Z(k)-H*X_pre;                %新息
    Xkf(k)=X_pre+Kg*e;             %状态更新
    p(k)=(I-Kg*H)*P_pre;           %协方差更新 
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算误差
E_Messure=zeros(1,N);  %计算测量值和真实值之间的偏差
E_Kalman=zeros(1,N);   %记录Kalman估计值和真实值之差

for k=1:N
    E_Messure(k)=abs(Z(k)-X(k));
    E_Kalman(k)=abs(Xkf(k)-X(k));
end
%计算误差的均值，作比较
Ave_messure=sum(E_Messure)/N;
Ave_Kalman=sum(E_Kalman)/N;

fprintf('测量值和真实值之间误差平均值是:%d\n',Ave_messure);
fprintf('滤波后值和真实值之间误差平均值是:%d\n',Ave_Kalman);
if Ave_messure-Ave_Kalman
   fprintf('滤波效果良好\n')
end
    
%画图显示结果
t=1:N;
figure
 
plot(t,Xexpect,'-',t,X,'-k.',t,Z,'-g*',t,Xkf,'-r.');
legend('期望值','真实值','观测值','Kalman滤波值')
 
 xlabel('SOC');
 ylabel('OCV');
 
 %误差图分析
 figure
 plot(t,E_Messure,'-b.',t,E_Kalman,'-k*');
 legend('测量误差','Kalman滤波误差')
 xlabel('采样时间');
 ylabel('误差值'); 
