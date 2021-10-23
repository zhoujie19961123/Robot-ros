% 程序说明：Kalman滤波用于温度测量的实例
clc;
clear;
N=100;
CON=24;%房间温度在24摄氏度左右
Xexpect=CON*ones(1,N);
X=zeros(1,N);  
Xkf=zeros(1,N);
Z=zeros(1,N);
P=zeros(1,N); 
X(1)=23.5;%真实值
P(1)=1;
Z(1)=24;%测量值
Xkf(1)=Z(1);
Q=0.001;%W(k)的方差
R=1;%V(k)的方差
W=sqrt(Q)*randn(1,N);
V=sqrt(R)*randn(1,N);
A=1;
B=1;
H=1;
I=eye(1); 
%%%%%%%%%%%%%%%%%%%%%%%
for k=2:N
    X(k)=A*X(k-1)+B*W(k-1);  
    Z(k)=H*X(k)+V(k);
    
    X_pre=A*Xkf(k-1);           
    P_pre=A*P(k-1)*A'+Q;%先验误差协方差      
    Kg=P_pre*inv(H*P_pre*H'+R); 
    e=Z(k)-H*X_pre;            
    Xkf(k)=X_pre+Kg*e;         
    P(k)=(I-Kg*H)*P_pre;
end
%%%%%%%%%%%%%%%%
Err_Messure=zeros(1,N);
Err_Kalman=zeros(1,N);
for k=1:N
    Err_Messure(k)=abs(Z(k)-X(k));
    Err_Kalman(k)=abs(Xkf(k)-X(k));
end
t=1:N;
figure('Name','Kalman Filter Simulation','NumberTitle','off');
plot(t,Xexpect,'-b',t,X,'-r',t,Z,'-k',t,Xkf,'-g');
legend('期望','真实','测量','卡尔曼');         
xlabel('sample time');
ylabel('temperature');

title('Kalman Filter Simulation');
figure('Name','Error Analysis','NumberTitle','off');
plot(t,Err_Messure,'-b',t,Err_Kalman,'-k');
legend('messure error','kalman error');         
xlabel('sample time');
%%%%%%%%%%%%%%%%%%%%%%%%%
