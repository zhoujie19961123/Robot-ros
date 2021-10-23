%�������,��һ�����ߣ��������ߣ������Ĵ�


clc;
clear all;
z=[66.6 84.9 88.6 78.0 96.8 105.2 93.2 111.6 88.3 117.0 115.2]';


plot(z,'o--');
xlabel('SOC');
ylabel('OCV');

%ʹ��һ�������������z(k)=a1k+a0+w(k)
 
k=1:11;
Hk1=[k;ones(1,11)]'; %��������Hk
estim1 = inv(Hk1'*Hk1)*Hk1'*z   %inv���������С���˷��ļ��㹫ʽ
 
ze1=estim1(1)*k+estim1(2); %ʹ�ü��������¹�������

wucha1=sum((ze1-z').^2)   %��С���˷�����ʹ���������ƽ������С

%�������������Ĳ���
for i=12:15
    ze1(i)=estim1(1)*i+estim1(2);
end


% ָ��x������귶Χ
xlim([0,15]);
%�����м����Ŀ̶ȣ��޸�Ϊ1����
set( gca, 'xtick', [0:1:15])

hold on;

plot(ze1);

%ʹ�ö����������z(k)=a2k^2+a1k+a0+w(k)

Hk2=[k.^2;k;ones(1,11)]';

estim2 = inv(Hk2'*Hk2)*Hk2'*z 
ze2=estim2(1)*k.^2+estim2(2)*k+estim2(3);  %��������

wucha2=sum((ze2-z').^2)

for i=12:15
    ze2(i)=estim2(1)*i.^2+estim2(2)*i+estim2(3);
end

hold on;
plot(ze2);


%ʹ�������������z(k)=a3.^3+a2k^2+a1k+a0+w(k)

Hk3=[k.^3;k.^2;k;ones(1,11)]';

estim3 = inv(Hk3'*Hk3)*Hk3'*z 
ze3=estim3(1)*k.^3+estim3(2)*k.^2+estim3(3)*k+estim3(4);  %��������

wucha3=sum((ze3-z').^2)

for i=12:10
    ze3(i)=estim3(1)*i.^3+estim3(2)*i.^2+estim3(3)*i+estim3(4);
end

hold on;
plot(ze3);

%ʹ���Ĵ��������z(k)=a4.^4+a3.^3+a2k^2+a1k+a0+w(k)

Hk4=[k.^4;k.^3;k.^2;k;ones(1,11)]';

estim4 = inv(Hk4'*Hk4)*Hk4'*z 
ze4=estim4(1)*k.^4+estim4(2)*k.^3+estim4(3)*k.^2+estim4(4)*k+estim4(5);  %�Ĵ�����

wucha4=sum((ze4-z').^2)

for i=12:15
    ze4(i)=estim4(1)*i.^4+estim4(2)*i.^3+estim4(3)*i.^2+estim4(4)*i+estim4(5); 
end

hold on;
plot(ze4);

legend('ԭʼ����','һ������','��������','��������','�Ĵ�����');











