% �ռ䵥һֱ��λ�ò岹�뵥Ԫ��Ԫ����̬�岹 + ���μӼ��ٹ�һ������/S�ͼӼ������߹�һ������
% 	Copyright: xuuyann
% 	Author: xuuyann
% 	Description: 
% ���������Sλ�ã� �յ�Dλ��
%      ���S�ĵ�Ԫ��Ԫ��Qs���յ�ĵ�Ԫ��Ԫ��Qd
%      ��ʼ�ٶ�v0����ֹ�ٶ�v1������ٶ�vmax�������ٶ�amax�����Ӽ��ٶ�jmax
%      �岹����t
% ����ֵ����ֵ��λ�á���Ԫ��Ԫ������ֵ����(qd, qdd, T��Ϊ����ͼ)
function [x,y,z,qk,N, qd, qdd, T] = SpaceLine_Q(S, D, Qs, Qd, v0, v1, vmax, amax, jmax, t)
x1 = S(1); y1 = S(2); z1 = S(3);
x2 = D(1); y2 = D(2); z2 = D(3);

P = 1; % ��ֵ���������Ӳ�ֵ�����������С
% ��λ��S
s = sqrt(power(x2 - x1, 2) + power(y2 - y1, 2) + power(z2 - z1, 2));
% ��ֵ����N
% N = ceil(P*s / vs)
% ���һ�����������μӼ�������
% function lambda = Normalization(pos, vel, accl, N)
% lambda = Normalization(s, vs, a, N);
% ���һ��������S�ͼӼ�������
% function lambda = Normalization_S(pos, v0, v1, vmax, amax, jmax, N)
[lambda, N, qd, qdd, T] = Normalization_S(s, v0, v1, vmax, amax, jmax, t);
delta_x = x2 - x1;
delta_y = y2 - y1;
delta_z = z2 - z1;
% ����������Ԫ��֮��ļн�
dot_q = Qs.s*Qd.s + Qs.v(1)*Qd.v(1) + Qs.v(2)*Qd.v(2) + Qs.v(3)*Qd.v(3);
if (dot_q < 0)
    dot_q = -dot_q;
end
 
for i = 1: N
    % λ�ò岹
    x(i) = x1 + delta_x*lambda(i);
    y(i) = y1 + delta_y*lambda(i);
    z(i) = z1 + delta_z*lambda(i);
    % ��λ��Ԫ������������̬�岹
    % ��ֵ����Ԫ��
    if (dot_q > 0.9995)
        k0 = 1-lambda(i);
        k1 = lambda(i);
    else
        sin_t = sqrt(1 - power(dot_q, 2));
        omega = atan2(sin_t, dot_q);
        k0 = sin((1-lambda(i))*omega) / sin(omega);
        k1 = sin(lambda(i)*omega) / sin(omega);
    end
    qk(i) = Qs * k0 + Qd * k1;
end

end