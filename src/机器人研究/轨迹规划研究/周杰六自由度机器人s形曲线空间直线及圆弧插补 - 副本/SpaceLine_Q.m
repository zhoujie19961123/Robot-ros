% �ռ䵥һֱ��λ�ò岹�뵥Ԫ��Ԫ����̬�岹 + ���μӼ��ٹ�һ������/S�ͼӼ������߹�һ������
% ���������Sλ�ã� �յ�Dλ��
%      ���S�ĵ�Ԫ��Ԫ��Qs���յ�ĵ�Ԫ��Ԫ��Qd
%      ��ʼ�ٶ�v0����ֹ�ٶ�v1������ٶ�vmax�������ٶ�amax�����Ӽ��ٶ�jmax
%      �岹����t
% ����ֵ����ֵ��λ�á���Ԫ��Ԫ������ֵ����
function [x,y,z,qk,N] = SpaceLine_Q(S, D, Qs, Qd, v0, v1, vmax, amax, jmax, t)
x1 = S(1); y1 = S(2); z1 = S(3);
x2 = D(1); y2 = D(2); z2 = D(3);

% ��λ��S
s = sqrt(power(x2 - x1, 2) + power(y2 - y1, 2) + power(z2 - z1, 2));
%λ�ò�ֵ
[lambda, N] = Normalization_S(s, v0, v1, vmax, amax, jmax, t);
delta_x = x2 - x1;
delta_y = y2 - y1;
delta_z = z2 - z1;

% ����������Ԫ��֮��ļн�
dot_q = Qs(1)*Qd(1) + Qs(2)*Qd(2)+ Qs(3)*Qd(3) + Qs(4)*Qd(4);
if (dot_q < 0)
    dot_q = -dot_q;
end
%��ʼ���õ�����Ԫ��
qk=zeros(N,4);
for i = 1: N
    % λ�ò岹
    x(i) = x1 + delta_x*lambda(i);
    y(i) = y1 + delta_y*lambda(i);
    z(i) = z1 + delta_z*lambda(i);
    % ��λ��Ԫ������������̬�岹
    % ��ֵ����Ԫ��
    if (dot_q > 0.9995)
        k0(i) = 1-lambda(i);
        k1(i) = lambda(i);
    else
        sin_t = sqrt(1 - power(dot_q, 2));
        omega = atan2(sin_t, dot_q);
        k0(i)= sin((1-lambda(i))*omega) / sin(omega);
        k1(i)= sin(lambda(i)*omega) / sin(omega);
    end
    qk(i,:)=Qs*k0(i)+Qd*k1(i);
    i=i+1;
end

end
