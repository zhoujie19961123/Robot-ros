% �ռ�ֱ��λ�ò岹��RPY����̬�岹 + ���μӼ��ٹ�һ������
% ���������Sλ�ã� �յ�Dλ��, ĩ�����ٶ�vs�� �Ӽ��ٶ�a
%      ���S��RPY�ǡ��յ�D��RPY��
% ����ֵ����ֵ�㣨���������S���յ�D��
function [x,y,z,alp,beta,gama,N] = SpaceLine(S, D, S_, D_, vs, a)
x1 = S(1); y1 = S(2); z1 = S(3);
x2 = D(1); y2 = D(2); z2 = D(3);
alp1 = S_(1); beta1 = S_(2); gama1 = S_(3);
alp2 = D_(1); beta2 = D_(2); gama2 = D_(3);
P = 1; % ��ֵ���������Ӳ�ֵ�����������С
% ��λ��S
s = sqrt(power(x2 - x1, 2) + power(y2 - y1, 2) + power(z2 - z1, 2));
% ��ֵ����N
%ȡ��
N = ceil(P*s / vs);
% ���һ������
% function lambda = Normalization(pos, vel, accl, N)
lambda = Normalization(s, vs, a, N);
delta_x = x2 - x1;
delta_y = y2 - y1;
delta_z = z2 - z1;
delta_alp = alp2 - alp1;
delta_beta = beta2 - beta1;
delta_gama = gama2 - gama1;
for i = 1: N+1
    x(i) = x1 + delta_x*lambda(i);
    y(i) = y1 + delta_y*lambda(i);
    z(i) = z1 + delta_z*lambda(i);
    alp(i) = alp1 + delta_alp*lambda(i);
    beta(i) = beta1 + delta_beta*lambda(i);
    gama(i) = gama1 + delta_gama*lambda(i);
end
end
