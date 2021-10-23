% ������������������������û��ָ����ʼ�ٶ�v0����ֹ�ٶ�vn��Ҳ����v0��vnδ֪
% Input��
%   q���������λ��
%   t��������λ�ö�Ӧ��ʱ��
%   tt���岹����
% Output��
%   yy dyy ddyy���������ߺ���ֵ���ٶȡ����ٶ�ֵ
function [yy,dyy,ddyy] = cubicSpline_3(q, t, tt)
if length(q) ~= length(t)
    error('���������Ӧ�ɶ�');
end
n = length(q);
%ע�⣬ӦΪ�����㷨Ϊn+1���㣬ʵ�ʱ�дΪn���㣬��AΪn-1(����Ϊn)
c = zeros(n-1, 1);
% ����A�Ǹ�(n-1)*(n-1)��ѭ�����ԽǾ���
A = zeros(n-1);
for i = 1: n-1
    if i == 1
        Tn_1 = t(n) - t(n-1);
        T0 = t(i+1) - t(i);
        A(i, i) = 2*(Tn_1 + T0);
        A(i, i+1) = Tn_1;
        A(i, n-1) = T0;
        c(i, 1) = (3/(Tn_1*T0))*((Tn_1^2)*(q(i+1)-q(i))+(T0^2)*(q(n)-q(n-1)));
    else
        Tk_1 = t(i+1) - t(i);
        Tk = t(i) - t(i-1);
        c(i, 1) = (3/(Tk*Tk_1))*(Tk^2*(q(i+1)-q(i))+Tk_1^2*(q(i)-q(i-1)));
        if i == n-1
            A(i, 1) = Tk_1;
            A(i, i-1) = Tk_1;
            A(i, i) = 2*(Tk + Tk_1);
        else
            A(i, i-1) = Tk_1;
            A(i, i) = 2*(Tk + Tk_1);
            A(i, i+1) = Tk;
        end
    end
            
end
%������׷�Ϸ�ʹ��Ҫ��
% ������������õ�����A��c
vk = A \ c; % ��һ��matlab���������Ӧ����׷�Ϸ���vk
% ���vk�ĵ�һ��ֵΪv0��Ȼ��v0��vn���
% �õ��м�岹����ٶ�vk��Ȼ�����cubicSpline_1����
v_ = [vk', vk(1)];
% v_ = [-2.28 -2.78 2.99 5.14 2.15 -1.8281 -2.28]
[yy,dyy,ddyy] = cubicSpline_1(q, t, v_, tt);


end



