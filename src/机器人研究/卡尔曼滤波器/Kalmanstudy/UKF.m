%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ����˵����UKF��Ŀ����ٵ��е�Ӧ��

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
T=1;                                     %�״��ɨ������
N=60/T;                                  %�ܵĲ�������
X=zeros(4,N);                            %Ŀ�����ʵλ�ú��ٶ�
X(:,1)=[-100,2,200,20];                  %Ŀ��ĳ�ʼλ�ú��ٶ�
Z=zeros(1,N);                            %��������λ�õĹ۲�
%Z(:,1)=[X(1,1),X(3,1)];                  %�����ĳ�ʼλ��

delta_w=1e-3; 
Q=delta_w*diag([0.5,1]);                 %������������

G=[T^2/2,0;T,0;0,T^2/2;0,T];            %������������
R=5;                                    %�۲���������

F=[1,T,0,0;0,1,0,0;0,0,1,T;0,0,0,1];     %״̬ת�ƾ���

x0=200;                      %�۲�վ��λ��
y0=300;
Xstation=[x0,y0];


for t=2:N    
    %��һ����Ŀ�����ʵ�켣
    X(:,t)=F*X(:,t-1)+G*sqrtm(Q)*randn(2,1);
    
end

v=sqrtm(R)*randn(1,N);
for t=1:N    
    %�ڶ�������Ŀ��Ĺ۲�
     Z(t)=RMS(X(:,t),Xstation)+v(t); 
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%UKF�˲���UT�任
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
Wc(1)=ramda/(L+ramda)+1-alpha^2+belta;   %Ȩֵ����

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xukf=zeros(4,N);
Xukf(:,1)=X(:,1);
P0=eye(4);

for t=2:N
    
    xestimate=Xukf(:,t-1);
    P=P0;
    
    %% ��һ�������һ��Sigma��
    cho=(chol(P*(L+ramda)))';  %chol���������ֽ�
    
    for k=1:L
        xgamaP1(:,k)=xestimate+cho(:,k);
        xgamaP2(:,k)=xestimate-cho(:,k);
    end
    Xsigma=[xestimate xgamaP1 xgamaP2];  %Sigma�㼯
    
    %% �ڶ�������Sigma�㼯����һ��Ԥ��
    
    Xsigmare=F*Xsigma;
    
    %% �����������õڶ����Ľ�������ֵ��Э����
    
    Xpred=zeros(4,1);  %��ֵ
    
     for k=1:2*L+1
        Xpred=Xpred+Wm(k)*Xsigmare(:,k);
     end
    
     Ppred=zeros(4,4);
    
     for k=1:2*L+1      %Э�������Ԥ��
        Ppred=Ppred+Wc(k)*(Xsigmare(:,k)-Xpred)*(Xsigmare(:,k)-Xpred)';
     end
     
     Ppred=Ppred+G*Q*G';
      
    %% ����Ԥ��ֵ��һ��ʹ��UT�任���õ��µ�Sigma�㼯
    
    chor=(chol(Ppred*(L+ramda)))';  %chol���������ֽ�
    
    for k=1:L
        xercisigmaP1(:,k)=Xpred+chor(:,k);
        xercisigmaP2(:,k)=Xpred-chor(:,k);
    end
    Xercisigma=[Xpred xercisigmaP1 xercisigmaP2]; 
    
    %% ���岽���۲�Ԥ��
    
    for k=1:2*L+1      
        Zsigmapre(1,k)=hhfun(Xercisigma(:,k),Xstation);
    end
     
    %% ������������۲�Ԥ���ֵ��Э����
    
    Zpred=0;      %�۲�Ԥ��ľ�ֵ
    
    for k=1:2*L+1
        Zpred=Zpred+Wm(k)*Zsigmapre(1,k);
    end
    
    Pzz=0;    
     for k=1:2*L+1
        Pzz=Pzz+Wc(k)*(Zsigmapre(1,k)-Zpred)*(Zsigmapre(1,k)-Zpred)';
     end
    
    Pzz=Pzz+R;       %�õ�Э����Pzz   
    Pxz=zeros(4,1);    
     for k=1:2*L+1
        Pxz=Pxz+Wc(k)*(Xercisigma(:,k)-Xpred)*(Zsigmapre(1,k)-Zpred)';
     end
   
    %% ���߲������㿨��������
    K=Pxz*inv(Pzz);
    
    %% �ڰ˲���״̬�ͷ������
    xestimate=Xpred+K*(Z(t)-Zpred);
    P=Ppred-K*Pzz*K';
    P0=P;
    Xukf(:,t)=xestimate;
    
end

%% �������

for t=1:N
  
    Erro_UKFKalman(t)=RMS(X(:,t),Xukf(:,t));   %�˲�������
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%��ͼ��ʾ���

figure
hold on;box on;
plot(X(1,:),X(3,:),'-k.');  %��ʵ�Ĺ켣

plot(Xukf(1,:),Xukf(3,:),'-r*');  %�˲���Ĺ켣

legend('��ʵ�켣','UKF�˲���켣');

 xlabel('������ X/m');
 ylabel('������ Y/m');
 title('UKF����Ŀ��');
 
 %���ͼ����
 figure
hold on;box on;

plot(Erro_UKFKalman,'-ks','Markerface','r')
legend('UKF�˲������')
 xlabel('����ʱ��');
 ylabel('���ֵ'); 

