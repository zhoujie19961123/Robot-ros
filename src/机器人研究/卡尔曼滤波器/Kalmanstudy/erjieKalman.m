%%%%%%%%%%%%%%%%%%%%%%%%

% 功能说明：kalman滤波在自由落体运动当中的运用
% 此时系统成为二维
% 可以很好的处理高斯白噪声

%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;
N=1000 ;    %采样点的个数，时间单位是秒

% 噪声
Q=[0,0;0,0];  %过程噪声方差为0，即为没有空气阻力
R=1;      %测量噪声
W=sqrt(Q)*randn(2,N); %过程噪声的大小模拟
V=sqrt(R)*randn(1,N); %测量值噪声

% 系统矩阵设置
F=[1,1;0,1];    %状态转移矩阵
G=[0.5;1];    %控制矩阵
H=[1,0];    %观测矩阵
U=-1;
I=eye(2);  %因为系统状态是一维的


% 对状态和测量初始化

X=zeros(2,N);           %物体的真实状态
X(:,1)=[95;1];          %初始的位移和速度
Xkf=zeros(2,N);         %kalman滤波的估计值
Xkf(:,1)=X(:,1);        
Z=zeros(1,N);           %位移的测量值
Z(1)=H*X(:,1);          %初始的观测值
 
P0=[10,0;0,1];          %初始的误差
err_P=zeros(N,2);      
err_P(1,1)=P0(1,1);   
err_P(1,2)=P0(2,2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 模拟下落过程

for k=2:N
    
    %第一步：物体下落位移和速度的真实值不断变化
    X(:,k)=F*X(:,k-1)+G*U;  %其实就是复现了状态方程
    
    %第二步：位移传感器的观测
    Z(k)=H*X(:,k)+V(k);
    
    %第三步：Kalman滤波，代入公式
    X_pre=F*Xkf(:,k-1)+G*U;              %状态预测
    P_pre=F*P0*F'+Q;                 %协方差预测
    Kg=P_pre*H'*inv(H*P_pre*H'+R);       %计算卡尔曼增益
    e=Z(k)-H*X_pre;                      %新息
    Xkf(:,k)=X_pre+Kg*e;                 %状态更新
    P0=(I-Kg*H)*P_pre;                 %协方差更新 
    
    
    %误差的均方值
    err_P(k,1)=P0(1,1); 
    
    err_P(k,2)=P0(2,2);
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算误差
Ex_Messure=zeros(1,N);  %计算位移测量值和真实值之间的偏差
Ex_Kalman=zeros(1,N);   %记录位移的Kalman估计值和真实值之差
Ev_Messure=zeros(1,N);  %计算速度测量值和真实值之间的偏差
Ev_Kalman=zeros(1,N);   %记录速度的Kalman估计值和真实值之差

for k=1:N
    Ex_Messure(k)=Z(k)-X(1,k);
    Ex_Kalman(k)=Xkf(1,k)-X(1,k);
    Ev_Messure(k)=Xkf(2,k)-X(2,k);
    Ev_Kalman(k)=Xkf(2,k)-X(2,k);
end

%计算误差的均值，作比较
%Ave_messure=sum(Ex_Messure)/N;
%Ave_Kalman=sum(Ex_Kalman)/N;

%fprintf('位移测量值和真实值之间误差平均值是:%d\n',Ave_messure);
%fprintf('位移滤波后值和真实值之间误差是:%d\n',Ave_Kalman);
%if Ave_messure-Ave_Kalman
%   fprintf('滤波效果良好\n')
%end
    
%画图显示结果
%figure
%hold on,box on;

%plot(X(1,:))

%plot(Xkf(1,:))

%plot(Z)
%axis([0 1000 0 95]);
%legend('真实位置','Kalman估计位置','测量位置')
%xlabel('采样时间/s');
%ylabel('位置');

figure
plot(V);
xlabel('采样时间/s');
ylabel('测量噪声');
 
 %位置偏差
 figure
 hold on,box on;
 plot(Ex_Messure,'-r.'); %测量的位移误差
 plot(Ex_Kalman,'-g.'); 
 legend('测量位置误差','Kalman估计误差')
 xlabel('采样时间/s');
 ylabel('位置偏差/m');
 
 %kalman速度偏差
 figure
 plot(Ev_Kalman);
 xlabel('采样时间/s');
 ylabel('速度偏差');

 %速度其实没有所谓的真实值和Kalman滤波值之间的偏差，因为我们给的协方差为0而且不考虑空气阻力
 %%%%%%%%%%%%%
 
 %均方差
 figure
 plot(err_P(:,1));
 xlabel('采样时间/s');
 ylabel('位移误差均方值');
 
 figure
 plot(err_P(:,2));
 xlabel('采样时间/s');
 ylabel('速度误差均方值');
 
 
 
 
 
 
 
 
 
 
 
