% ��ȡת���˶��������ٶȼ��ٶȣ�
% 	Copyright: xuuyann
% 	Author: xuuyann
% 	Description: 
% ������ �ֶ�·������d1,d2,d3
%       P0��P1��P2���ٶ�v0, v1, v2��P1Ϊ�м�㣩
%       �����ٶ�amax,���Ӽ��ٶ�jmax
% ����ֵ�� ת�ӵ��ٶ�vt����Ϊ·�����ܹ��ﵽ������ٶȣ�
function [vt] = TransMotionPara(d1, d2, d3, v0, v1, v2, amax, jmax)
% �õ��滮����Ta, Tv, Td, Tj1, Tj2, q0, q1, v0, v1, vlim, amax, amin, alima, alimd, jmax, jmin
q0 = 0; q1 = d1 + d2 + d3;
para = STrajectoryPara(q0, q1, v0, v2, v1, amax, jmax);
vt = para(10);
end