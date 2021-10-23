% ʰȡ���ò����ֶ�·��ת��ģ��
% 	Copyright: xuuyann
% 	Author: xuuyann
% 	Description: 
% ������ �û��趨������ʰ��·����P0,P1,P2��λ��
%       ���ɰ뾶r
%       �岹����t
% ����ֵ�� ת�ӵ�Pt1��Pt2���ָ���С·������d1,d2,Բ��C��Բ�Ľ�theta
%         
function [Pt1, Pt2, d1, d2, C, theta] = PathSegmentTrans(P0, P1, P2, r, t)
% ��ս�theta
P1P0 = sqrt(power(P0(1) - P1(1), 2) + power(P0(2) - P1(2), 2) + power(P0(3) - P1(3), 2));
P1P2 = sqrt(power(P2(1) - P1(1), 2) + power(P2(2) - P1(2), 2) + power(P2(3) - P1(3), 2));
vec_P1P0 = [P0(1) - P1(1), P0(2) - P1(2), P0(3) - P1(3)];
vec_P1P2 = [P2(1) - P1(1), P2(2) - P1(2), P2(3) - P1(3)];
theta = acos((dot(vec_P1P0, vec_P1P2)) / (P1P0*P1P2));%�������
% ��ת�ӵ�Pt1��Pt2
vec_P1Pt1 = (r/tan(theta/2)/P1P0) * vec_P1P0;
vec_P1Pt2 = (r/tan(theta/2)/P1P2) * vec_P1P2;
Pt1 = P1 + vec_P1Pt1;
Pt2 = P1 + vec_P1Pt2;
% ��·������d1������d2
d1 = sqrt(power(Pt1(1) - P0(1), 2) + power(Pt1(2) - P0(2), 2) + power(Pt1(3) - P0(3), 2));
d2 = (pi - theta) * r;
% % ��ת���ٶ�vt
% ���ǿ��ǻ�еϵͳ����ѧ�������صõ���ת���ٶ�
% a = sqrt(Amax * r);
% b = d2 / t;
% if (a > b)
%     vt  = b;
% else
%     vt = a;
% end

% ��Բ��C
vec_Pt1M = (1/2) * (Pt2 - Pt1);
M = Pt1 + vec_Pt1M;
vec_P1M = M - P1;
P1M = sqrt(power(M(1) - P1(1), 2) + power(M(2) - P1(2), 2) + power(M(3) - P1(3), 2));
P1C = r / sin(theta/2);
vec_P1C = (P1C / P1M) * vec_P1M;
C = P1 + vec_P1C;
end