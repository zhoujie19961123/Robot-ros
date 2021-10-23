%拟合曲线,有一次曲线，二次曲线，三次四次


clc;
clear all;
z=[66.6 84.9 88.6 78.0 96.8 105.2 93.2 111.6 88.3 117.0 115.2]';


plot(z,'o--');
xlabel('SOC');
ylabel('OCV');

%使用一次线性曲线拟合z(k)=a1k+a0+w(k)
 
k=1:11;
Hk1=[k;ones(1,11)]'; %测量矩阵Hk
estim1 = inv(Hk1'*Hk1)*Hk1'*z   %inv是逆矩阵，最小二乘法的计算公式
 
ze1=estim1(1)*k+estim1(2); %使用计算结果重新构建曲线

wucha1=sum((ze1-z').^2)   %最小二乘法就是使得这个误差的平方和最小

%计算接下来四年的产量
for i=12:15
    ze1(i)=estim1(1)*i+estim1(2);
end


% 指定x轴的坐标范围
xlim([0,15]);
%设置中间间隔的刻度，修改为1即可
set( gca, 'xtick', [0:1:15])

hold on;

plot(ze1);

%使用二次曲线拟合z(k)=a2k^2+a1k+a0+w(k)

Hk2=[k.^2;k;ones(1,11)]';

estim2 = inv(Hk2'*Hk2)*Hk2'*z 
ze2=estim2(1)*k.^2+estim2(2)*k+estim2(3);  %二次曲线

wucha2=sum((ze2-z').^2)

for i=12:15
    ze2(i)=estim2(1)*i.^2+estim2(2)*i+estim2(3);
end

hold on;
plot(ze2);


%使用三次曲线拟合z(k)=a3.^3+a2k^2+a1k+a0+w(k)

Hk3=[k.^3;k.^2;k;ones(1,11)]';

estim3 = inv(Hk3'*Hk3)*Hk3'*z 
ze3=estim3(1)*k.^3+estim3(2)*k.^2+estim3(3)*k+estim3(4);  %三次曲线

wucha3=sum((ze3-z').^2)

for i=12:10
    ze3(i)=estim3(1)*i.^3+estim3(2)*i.^2+estim3(3)*i+estim3(4);
end

hold on;
plot(ze3);

%使用四次曲线拟合z(k)=a4.^4+a3.^3+a2k^2+a1k+a0+w(k)

Hk4=[k.^4;k.^3;k.^2;k;ones(1,11)]';

estim4 = inv(Hk4'*Hk4)*Hk4'*z 
ze4=estim4(1)*k.^4+estim4(2)*k.^3+estim4(3)*k.^2+estim4(4)*k+estim4(5);  %四次曲线

wucha4=sum((ze4-z').^2)

for i=12:15
    ze4(i)=estim4(1)*i.^4+estim4(2)*i.^3+estim4(3)*i.^2+estim4(4)*i+estim4(5); 
end

hold on;
plot(ze4);

legend('原始曲线','一次曲线','二次曲线','三次曲线','四次曲线');











