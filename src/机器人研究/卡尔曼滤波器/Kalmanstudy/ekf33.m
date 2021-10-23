%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 功能说明：EKF在纯方位目标跟踪当中的应用,角度关系

%观测效果较差，角度与x,y有非线性关系。状态是四维的，但是观测是一维信息

%最后EKF算法几乎发散，在非线性系统中要根据初始状态和观测信息达到对目标的
%持续跟踪是很困难的

%可以看出，这系统非常依赖初始状态

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
T=1;                                     %雷达的扫描周期
N=40/T;                                  %总的采样次数
X=zeros(4,N);                            %目标的真实位置和速度
X(:,1)=[0,2,1400,-10];                   %目标的初始位置和速度
Z=zeros(1,N);                            %传感器对位置的观测
%Z(:,1)=[X(1,1),X(3,1)];                 %船舶的初始位置

delta_w=1e-3; 
Q=delta_w*diag([1,1]);                 %过程噪声方差

G=[T^2/2,0;T,0;0,T^2/2;0,T];            %噪声驱动矩阵
R=0.1*pi/180;

F=[1,T,0,0;0,1,0,0;0,0,1,T;0,0,0,1];     %状态转移矩阵

x0=0;                    %观测站的位置    
y0=1000;
Xstation=[x0;y0];   

v=sqrtm(R)*randn(1,N);      %观测噪声


for t=2:N    
    %第一步：目标的真实轨迹
    X(:,t)=F*X(:,t-1)+G*sqrtm(Q)*randn(2,1);
    
end


for t=1:N    
    %第二步：对目标的观测,利用hfun函数转换成角度
     Z(t)=hfun(X(:,t),Xstation)+v(t); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xekf=zeros(4,N);
Xekf(:,1)=X(:,1);     %Kalman滤波器初始化      
P0=eye(4);           %滤波误差协方差矩阵


for k=2:N

    Xn=F*Xekf(:,k-1);              %状态预测
    P1=F*P0*F'+G*Q*G';                 %协方差预测
    
    dd=hfun(Xn,Xstation);
    D=RMS(Xn,Xstation);
    
    %求雅可比矩阵（各自求偏导数）
    %即随求就是一阶近似
    H=[-(Xn(3,1)-y0)/D,0,(Xn(1,1)-x0)/D,0];
    
    Kg=P1*H'*inv(H*P1*H'+R);   %计算卡尔曼增益
    e=Z(:,k)-dd;                %新息
    Xekf(:,k)=Xn+Kg*e;             %状态更新
    P0=(eye(4)-Kg*H)*P1;          %协方差更新 
    
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算误差

Erro_Kalman=zeros(1,N);   %记录Kalman估计值和真实值之差

for k=1:N
  
    Erro_Kalman(k)=sqrt(RMS(X(:,k),Xekf(:,k)));   %滤波后的均方误差
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%画图显示结果

figure
hold on;box on;
plot(X(1,:),X(3,:),'-K.');  %真实的轨迹

plot(Xekf(1,:),Xekf(3,:),'-r*');  %滤波后的轨迹

legend('真实轨迹','EKF滤波后轨迹');

 xlabel('横坐标 X/m');
 ylabel('纵坐标 Y/m');
 
 %误差图分析
 figure
hold on;box on;

plot(Erro_Kalman,'-ks','Markerface','r')
legend('滤波后误差')
 xlabel('采样时间');
 ylabel('误差值'); 
 
  
  figure
hold on;box on;

plot(Z/pi*180,'-rs','Markerface','r');
plot(Z/pi*180+v/pi*180,'-ko','Markerface','g');
legend('真实角度','观测的角度');

 xlabel('时间/s');
 ylabel('角度值/度'); 
 
  figure
hold on;box on;

plot(v,'-ks','Markerface','r')

 xlabel('时间');
 ylabel('观测噪声'); 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

