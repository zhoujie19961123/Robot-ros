%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 功能说明：UKF在目标跟踪当中的应用

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
T=1;                                     %雷达的扫描周期
N=60/T;                                  %总的采样次数
X=zeros(4,N);                            %目标的真实位置和速度
X(:,1)=[-100,2,200,20];                  %目标的初始位置和速度
Z=zeros(1,N);                            %传感器对位置的观测
%Z(:,1)=[X(1,1),X(3,1)];                  %船舶的初始位置

delta_w=1e-3; 
Q=delta_w*diag([0.5,1]);                 %过程噪声方差

G=[T^2/2,0;T,0;0,T^2/2;0,T];            %噪声驱动矩阵
R=5;                                    %观测噪声方差

F=[1,T,0,0;0,1,0,0;0,0,1,T;0,0,0,1];     %状态转移矩阵

x0=200;                      %观测站的位置
y0=300;
Xstation=[x0,y0];


for t=2:N    
    %第一步：目标的真实轨迹
    X(:,t)=F*X(:,t-1)+G*sqrtm(Q)*randn(2,1);
    
end

v=sqrtm(R)*randn(1,N);
for t=1:N    
    %第二步：对目标的观测
     Z(t)=RMS(X(:,t),Xstation)+v(t); 
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%UKF滤波，UT变换
L=4;
alpha=1;
kalpha=0;
belta=2;
ramda=3-L;

for j=1:2*L+1
    Wm(j)=1/(2*(L+ramda));
    Wc(j)=1/(2*(L+ramda));
end
Wm(1)=ramda/(L+ramda);
Wc(1)=ramda/(L+ramda)+1-alpha^2+belta;   %权值计算

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xukf=zeros(4,N);
Xukf(:,1)=X(:,1);
P0=eye(4);

for t=2:N
    
    xestimate=Xukf(:,t-1);
    P=P0;
    
    %% 第一步：获得一组Sigma点
    cho=(chol(P*(L+ramda)))';  %chol是做正定分解
    
    for k=1:L
        xgamaP1(:,k)=xestimate+cho(:,k);
        xgamaP2(:,k)=xestimate-cho(:,k);
    end
    Xsigma=[xestimate xgamaP1 xgamaP2];  %Sigma点集
    
    %% 第二步：对Sigma点集进行一步预测
    
    Xsigmare=F*Xsigma;
    
    %% 第三步：利用第二步的结果计算均值和协方差
    
    Xpred=zeros(4,1);  %均值
    
     for k=1:2*L+1
        Xpred=Xpred+Wm(k)*Xsigmare(:,k);
     end
    
     Ppred=zeros(4,4);
    
     for k=1:2*L+1      %协方差矩阵预测
        Ppred=Ppred+Wc(k)*(Xsigmare(:,k)-Xpred)*(Xsigmare(:,k)-Xpred)';
     end
     
     Ppred=Ppred+G*Q*G';
      
    %% 根据预测值再一次使用UT变换，得到新的Sigma点集
    
    chor=(chol(Ppred*(L+ramda)))';  %chol是做正定分解
    
    for k=1:L
        xercisigmaP1(:,k)=Xpred+chor(:,k);
        xercisigmaP2(:,k)=Xpred-chor(:,k);
    end
    Xercisigma=[Xpred xercisigmaP1 xercisigmaP2]; 
    
    %% 第五步：观测预测
    
    for k=1:2*L+1      
        Zsigmapre(1,k)=hhfun(Xercisigma(:,k),Xstation);
    end
     
    %% 第六步：计算观测预测均值和协方差
    
    Zpred=0;      %观测预测的均值
    
    for k=1:2*L+1
        Zpred=Zpred+Wm(k)*Zsigmapre(1,k);
    end
    
    Pzz=0;    
     for k=1:2*L+1
        Pzz=Pzz+Wc(k)*(Zsigmapre(1,k)-Zpred)*(Zsigmapre(1,k)-Zpred)';
     end
    
    Pzz=Pzz+R;       %得到协方差Pzz   
    Pxz=zeros(4,1);    
     for k=1:2*L+1
        Pxz=Pxz+Wc(k)*(Xercisigma(:,k)-Xpred)*(Zsigmapre(1,k)-Zpred)';
     end
   
    %% 第七步：计算卡尔曼增益
    K=Pxz*inv(Pzz);
    
    %% 第八步：状态和方差更新
    xestimate=Xpred+K*(Z(t)-Zpred);
    P=Ppred-K*Pzz*K';
    P0=P;
    Xukf(:,t)=xestimate;
    
end

%% 计算误差

for t=1:N
  
    Erro_UKFKalman(t)=RMS(X(:,t),Xukf(:,t));   %滤波后的误差
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%画图显示结果

figure
hold on;box on;
plot(X(1,:),X(3,:),'-k.');  %真实的轨迹

plot(Xukf(1,:),Xukf(3,:),'-r*');  %滤波后的轨迹

legend('真实轨迹','UKF滤波后轨迹');

 xlabel('横坐标 X/m');
 ylabel('纵坐标 Y/m');
 title('UKF跟踪目标');
 
 %误差图分析
 figure
hold on;box on;

plot(Erro_UKFKalman,'-ks','Markerface','r')
legend('UKF滤波后误差')
 xlabel('采样时间');
 ylabel('误差值'); 

