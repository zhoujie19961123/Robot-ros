% ����������ָ����ʼ����ֹ�ٶ��Լ����ٶȣ�Ҳ����v0��vn��a0��an��֪
% ���������Ҫ������������ĵ�q1_��qn-1_
% q1_��ԭ��q1��q2֮�䣬qn-1_��ԭ�е�qn-1��qn֮��
% ������������Ӧ��ʱ��t1_��tn-1_��Ҫ���㣬��������ѡ�񣬱�����ѡ��ȡƽ��ֵ
% Input��
%   q���������λ��
%   t��������λ�ö�Ӧ��ʱ��
%   v0����ʼ�ٶ�
%   vn����ֹ�ٶ�
%   a0����ʼ���ٶ�
%   an����ֹ���ٶ�
%   tt���岹����
% Output��
%   yy dyy ddyy���������ߺ���ֵ���ٶȡ����ٶ�ֵ
function [yy,dyy,ddyy,q1,qn_1] = cubicSpline_4(q, t, v0, vn, a0, an, tt)
if length(q) ~= length(t)
    error('���������Ӧ�ɶ�');
end
n = length(q); % ԭ���ĵ�����
% �������������q1_��qn-1_�����������Ӧ��ʱ���
t1_ = (t(1)+t(2)) / 2;
tn_1_ = (t(n-1)+t(n)) / 2;
% ����ʱ������
t = [t(1), t1_, t(2: n-1), tn_1_, t(n)];
% ���µ������
n = n + 2;
% ����A�Ǹ�(n-2)�׶Խ�ռ�ž���
A = zeros(n-2);
c = zeros(n-2, 1);
for i = 1: n-2
    Tk_1 = t(i+2) - t(i+1);
    Tk = t(i+1) - t(i);
    if i == 1
        A(i, i) = 2*Tk_1 + Tk*(3+Tk/Tk_1);
        A(i, i+1) = Tk_1;
        c(i, 1) = 6*((q(2)-q(1))/Tk_1-v0*(1+Tk/Tk_1)-a0*(0.5+Tk/(3*Tk_1))*Tk);
    elseif i == 2
        T0 = t(2)-t(1);
        A(i, i-1) = Tk - (T0^2)/Tk;
        A(i, i) = 2*(Tk + Tk_1);
        A(i, i+1) = Tk_1;
        c(i, 1) = 6*((q(3)-q(2))/Tk_1-(q(2)-q(1))/Tk+v0*(T0/Tk)+a0*(T0^2)/(3*Tk));
    elseif i == n-2-1
        Tn_1 = t(n) - t(n-1);
        A(i, i-1) = Tk;
        A(i, i) = 2*(Tk + Tk_1);
        A(i, i+1) = Tk_1 - (Tn_1^2)/Tk_1;
        c(i, 1) = 6*((q(n-2)-q(n-3))/Tk_1-(q(n-3)-q(n-4))/Tk-vn*(Tn_1/Tk_1)+an*(Tn_1^2)/(3*Tk_1));
    elseif i == n-2
        A(i, i) = 2*Tk + Tk_1*(3+Tk_1/Tk);
        A(i, i-1) = Tk;
        c(i, 1) = 6*((q(n-3)-q(n-2))/Tk+vn*(1+Tk_1/Tk)-an*(0.5+Tk_1/(3*Tk))*Tk_1);
    else
        A(i, i-1) = Tk;
        A(i, i) = 2*(Tk + Tk_1);
        A(i, i+1) = Tk_1;
        c(i, 1) = 6*((q(i+1)-q(i))/Tk_1-(q(i)-q(i-1))/Tk);
    end
end
% ������������õ��Խ�ռ�ž���A��c
% wk = A \ c; % ��һ��matlab���������Ӧ����׷�Ϸ���vk
for i = 1: n-2
    a(i) = A(i, i); % �Խ���
    if i == n-3
        b(i) = A(i, i+1); % �ϱ�
        d(i) = A(i+1, i); % �±�
        continue;
    elseif i < n-2
        b(i) = A(i, i+1); % �ϱ�
        d(i) = A(i+1, i); % �±�
    end
end

[~, ~, wk] = crout(a, b, d, c); % ׷�Ϸ�
%׷�Ϸ��õ�����ֵ��ļ��ٶ�

n_ = length(wk);
%���ӵ�������q1��q��n-1����ֵ
q1 = q(1) + T0*v0 + ((T0^2)/3)*a0 + ((T0^2)/6)*wk(1);
Tn_1 = t(n) - t(n-1);
qn_1 = q(n-2) - Tn_1*vn + ((Tn_1^2)/3)*an + ((Tn_1^2)/6)*wk(n_);
% ����λ��q����
q = [q(1), q1, q(2: n-3), qn_1, q(n-2)];
% ���¼��ٶ�w����
w = [a0, wk, an];
% �滮�����켣
T = t(n) - t(1); % ������ʱ��
nn = T / tt; % �ܵ���
yy = zeros(1, nn);
dyy = zeros(1, nn);
ddyy = zeros(1, nn);
j = 1;
for i = 1: n-1
    Tk = t(i+1) - t(i);
    a0 = q(i);
    a1 = (q(i+1)-q(i))/Tk-(Tk/6)*(w(i+1)+2*w(i));
    a2 = w(i) / 2;
    a3 = (w(i+1)-w(i))/(6*Tk);
    
    for tk = t(i): tt: t(i+1)
        if i > 1 && tk == t(i)
            continue
        end
        yy(j) = a0 + a1*(tk-t(i)) + a2*power(tk-t(i), 2) + a3*power(tk-t(i), 3);
        dyy(j) = a1 + 2*a2*(tk-t(i)) + 3*a3*power(tk-t(i), 2);
        ddyy(j) = 2*a2 + 6*a3*(tk-t(i));
        j = j + 1;
    end
end

end
