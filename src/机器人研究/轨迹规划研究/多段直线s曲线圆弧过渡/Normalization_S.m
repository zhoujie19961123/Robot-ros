% ��һ������
% S�ͼӼ�������
% 	Copyright: xuuyann
% 	Author: xuuyann
% 	Description: 
% �����������е��ĩ���˶���λ�ƣ��Ƕȣ�pos 
%          ��е��ĩ�����ٶȣ����ٶȣ���ʼv0����ֹv1������ٶ�vmax
%          ���Ӽ��ٶ�amax�����Ӽ��ٶ�jmax
%          �岹����t
% ����ֵ�� ��ֵ����N,qd,qdd(Ϊ����ͼ),����ʱ��T
function [lambda, N, qd, qdd, T] = Normalization_S(pos, v0, v1, vmax, amax, jmax, t)
% S���߲������㣨S���ٶȹ滮���ֳ��߶�ʽ�켣��
% function para = STrajectoryPara(q0, q1, v0, v1, vmax, amax, jmax)
q0 = 0; q1 = pos;
para = STrajectoryPara(q0, q1, v0, v1, vmax, amax, jmax); % ��ȡS���߲���
% �ܵĹ滮ʱ��
T = para(1) + para(2) + para(3);
% ��ʱ�岹
N = ceil(T / t);
j = 1;
for i = 0 : t: T
   q(j) = S_position(i, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   qd(j) = S_velocity(i, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   qdd(j) = S_acceleration(i, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   lambda(j) = q(j) / pos;
   j = j + 1;
end

end