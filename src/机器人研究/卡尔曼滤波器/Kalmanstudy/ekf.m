%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 功能说明：标量非线性系统的EKF问题
%状态函数：X（k+1）=0.5X（k）+2.5X（k）/(1+X(k)^2)+8cos(1.2k)+w(k)
%观测方程：Z(k)=X(k)^2/20+v(k)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
T=50;                                    %总时间

for Q=1:2:10;                       %Q值的不同，观察滤波效果，过程噪声的方差值
    
R=1;                                 %测量噪声的方差值

w=sqrt(Q)*randn(1,T);   %产生过程噪声
v=sqrt(R)*randn(1,T);   %产生观测噪声

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%状态方程

x=zeros(1,T);                            %目标的真实状态
x(1)=0.1;                                %目标的初始状态
y=zeros(1,T);                          
y(1)=x(1)^2/20+v(1);                      %观测方程

for k=2:T
    x(k)=0.5*x(k-1)+2.5*x(k-1)/(1+x(k-1)^2)+8*cos(1.2*k)+w(k-1);
    %非线性系统动态方程
    
    y(k)=x(k)^2/20+v(k); %观测方程
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EKF算法初始化

Xekf=zeros(1,T);
Xekf(1)=x(1);         %Kalman滤波器初始化   
Yekf=zeros(1,T);
Yekf(1)=y(1); 
P0=eye(1);           %滤波误差协方差矩阵

for k=2:T

  
    %第三步：Kalman滤波，代入公式
    Xn=0.5*Xekf(k-1)+2.5*Xekf(k-1)/(1+Xekf(k-1)^2)+8*cos(1.2*k);       %状态预测
    Zn=Xn^2/20;   %观测预测
    
    %求状态矩阵F(状态方程求偏导)
    F=0.5+2.5*(1-Xn^2)/(1+Xn^2)^2;
    
    %求观测矩阵(观测矩阵求偏导)
    H=Xn/10;
    
    P1=F*P0*F'+Q;                  %协方差预测
    Kg=P1*H'*inv(H*P1*H'+R);       %计算卡尔曼增益
            
    Xekf(k)=Xn+Kg*(y(k)-Zn);       %状态更新
    P0=(eye(1)-Kg*H)*P1;           %协方差更新 
    
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算误差
Xstd=zeros(1,T);

for k=1:T
    Xstd(k)=abs(Xekf(k)-x(k));    %对应的数据相减的绝对值 
end

 junfanghcha=sum((Xekf-x).^2)/T;      %计算以下不同Q影响下的均方差
 fprintf('Q等于%d时的均方差为%d\n',Q,junfanghcha);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%画图显示结果

figure
hold on;box on;
plot(x,'-ko','Markerface','g')   %画出真实值
plot(Xekf,'-ks','Markerface','r')   %画出Kalman滤波值

legend('真实值','EKF估计值');

 xlabel('SOC');
 ylabel('OCV');
 
 %误差分析
figure
hold on;box on;
plot(Xstd,'-ko','Markerface','g')
 xlabel('时间');
 ylabel('状态估计偏差'); 
