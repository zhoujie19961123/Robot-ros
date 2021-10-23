%����ʽ��ֵ����
%method='nearst'���ֽ�������ó���������ݵ��ֵ
%method='linear' ��������֮������ֱ��
%method='spline' ����������ֵ
%method='cubic'  ������ֵ
%����ɢ���ݵĻ����ϲ�������������ʹ��������������ͨ��ȫ����������ɢ���ݵ㡣
%�涨��x�ļ���������õ�method���㺯��ֵ������ƽ����ͨ��ԭ�ȵ��������ݵ�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;    %����
clear all;   %����������������ϴ����н��Ӱ��
close all;    %�ر����д���

ys=10*rand(1,15);  %����1��15�е������

xs=0:length(ys)-1;   %���е�������,length������֮�е����ֵ
x=0:0.1:length(ys)-1;  %�µĲ�ֵ������

y1=interp1(xs,ys,x,'nearst');  %��ͬ�Ĳ�ֵ���������µ�������
y2=interp1(xs,ys,x,'linear');  
y3=interp1(xs,ys,x,'spline');  %����������ֵ
y4=interp1(xs,ys,x,'pchip');   %�ɰ����cubic

figure;
plot(x,y1,'.','color','b','MarkerSize',10);  %�����µ�������
hold on;

plot(xs,ys,'ro',x,y1,x,y2,x,y3,x,y4);    %��ͼ

legend('spline��ֵ������','ԭ������','nearst','linear','spline','pchip');  %ͼ��

title('����ʽ��ֵ����');    %����










%[xs,ys,z]=peaks(10);
%Ϊ�˷�����������ͼ��MATLAB�ṩ��һ��peaks������
%�ɲ���һ����͹���µ����棬�����������ֲ�����㼰�����ֲ���С��
%[xi,yi]=meshgrid(0:.1:15,min(ys):0.1:max(ys));
%zi=interp2(xs,ys,z,xi,yi);
%figure(2);

%mesh(xi,yi,zi),shading flat,title('��ά��ֵ');