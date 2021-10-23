%%%%%%%%%%%%%%%%%%%%%%%%

% ����˵����kalman�˲������������˶����е�����
% ��ʱϵͳ��Ϊ��ά
% ���ԺܺõĴ����˹������

%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;
N=1000 ;    %������ĸ�����ʱ�䵥λ����

% ����
Q=[0,0;0,0];  %������������Ϊ0����Ϊû�п�������
R=1;      %��������
W=sqrt(Q)*randn(2,N); %���������Ĵ�Сģ��
V=sqrt(R)*randn(1,N); %����ֵ����

% ϵͳ��������
F=[1,1;0,1];    %״̬ת�ƾ���
G=[0.5;1];    %���ƾ���
H=[1,0];    %�۲����
U=-1;
I=eye(2);  %��Ϊϵͳ״̬��һά��


% ��״̬�Ͳ�����ʼ��

X=zeros(2,N);           %�������ʵ״̬
X(:,1)=[95;1];          %��ʼ��λ�ƺ��ٶ�
Xkf=zeros(2,N);         %kalman�˲��Ĺ���ֵ
Xkf(:,1)=X(:,1);        
Z=zeros(1,N);           %λ�ƵĲ���ֵ
Z(1)=H*X(:,1);          %��ʼ�Ĺ۲�ֵ
 
P0=[10,0;0,1];          %��ʼ�����
err_P=zeros(N,2);      
err_P(1,1)=P0(1,1);   
err_P(1,2)=P0(2,2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ģ���������

for k=2:N
    
    %��һ������������λ�ƺ��ٶȵ���ʵֵ���ϱ仯
    X(:,k)=F*X(:,k-1)+G*U;  %��ʵ���Ǹ�����״̬����
    
    %�ڶ�����λ�ƴ������Ĺ۲�
    Z(k)=H*X(:,k)+V(k);
    
    %��������Kalman�˲������빫ʽ
    X_pre=F*Xkf(:,k-1)+G*U;              %״̬Ԥ��
    P_pre=F*P0*F'+Q;                 %Э����Ԥ��
    Kg=P_pre*H'*inv(H*P_pre*H'+R);       %���㿨��������
    e=Z(k)-H*X_pre;                      %��Ϣ
    Xkf(:,k)=X_pre+Kg*e;                 %״̬����
    P0=(I-Kg*H)*P_pre;                 %Э������� 
    
    
    %���ľ���ֵ
    err_P(k,1)=P0(1,1); 
    
    err_P(k,2)=P0(2,2);
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������
Ex_Messure=zeros(1,N);  %����λ�Ʋ���ֵ����ʵֵ֮���ƫ��
Ex_Kalman=zeros(1,N);   %��¼λ�Ƶ�Kalman����ֵ����ʵֵ֮��
Ev_Messure=zeros(1,N);  %�����ٶȲ���ֵ����ʵֵ֮���ƫ��
Ev_Kalman=zeros(1,N);   %��¼�ٶȵ�Kalman����ֵ����ʵֵ֮��

for k=1:N
    Ex_Messure(k)=Z(k)-X(1,k);
    Ex_Kalman(k)=Xkf(1,k)-X(1,k);
    Ev_Messure(k)=Xkf(2,k)-X(2,k);
    Ev_Kalman(k)=Xkf(2,k)-X(2,k);
end

%�������ľ�ֵ�����Ƚ�
%Ave_messure=sum(Ex_Messure)/N;
%Ave_Kalman=sum(Ex_Kalman)/N;

%fprintf('λ�Ʋ���ֵ����ʵֵ֮�����ƽ��ֵ��:%d\n',Ave_messure);
%fprintf('λ���˲���ֵ����ʵֵ֮�������:%d\n',Ave_Kalman);
%if Ave_messure-Ave_Kalman
%   fprintf('�˲�Ч������\n')
%end
    
%��ͼ��ʾ���
%figure
%hold on,box on;

%plot(X(1,:))

%plot(Xkf(1,:))

%plot(Z)
%axis([0 1000 0 95]);
%legend('��ʵλ��','Kalman����λ��','����λ��')
%xlabel('����ʱ��/s');
%ylabel('λ��');

figure
plot(V);
xlabel('����ʱ��/s');
ylabel('��������');
 
 %λ��ƫ��
 figure
 hold on,box on;
 plot(Ex_Messure,'-r.'); %������λ�����
 plot(Ex_Kalman,'-g.'); 
 legend('����λ�����','Kalman�������')
 xlabel('����ʱ��/s');
 ylabel('λ��ƫ��/m');
 
 %kalman�ٶ�ƫ��
 figure
 plot(Ev_Kalman);
 xlabel('����ʱ��/s');
 ylabel('�ٶ�ƫ��');

 %�ٶ���ʵû����ν����ʵֵ��Kalman�˲�ֵ֮���ƫ���Ϊ���Ǹ���Э����Ϊ0���Ҳ����ǿ�������
 %%%%%%%%%%%%%
 
 %������
 figure
 plot(err_P(:,1));
 xlabel('����ʱ��/s');
 ylabel('λ��������ֵ');
 
 figure
 plot(err_P(:,2));
 xlabel('����ʱ��/s');
 ylabel('�ٶ�������ֵ');
 
 
 
 
 
 
 
 
 
 
 
