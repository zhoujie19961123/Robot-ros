% ����Բ���Ĳ岹�㷨������ContinueSpaceLineʹ��
% 	Copyright: xuuyann
% 	Author: xuuyann
% 	Description: 
% ������ Pt1,Pt2,P1(Pt1��Pt2���м��),Qt1,Qt2
%       ����Բ������d�����ɰ뾶r���岹����t
%       Բ���岹�ٶ�vt
% ����ֵ�� �岹����N���岹ʱ��Tt
function [x,y,z,qk,N,Tt] = Transition_arc(Pt1, Pt2, P1, Qt1, Qt2, d, r, t, vt)
% ����������ϵUVW
% ��������V
vec_Pt1P1 = P1 - Pt1;
Pt1P1 = sqrt(power(P1(1) - Pt1(1), 2) + power(P1(2) - Pt1(2), 2) + power(P1(3) - Pt1(3), 2));
V = (1/Pt1P1) * vec_Pt1P1;
ox = V(1); oy = V(2); oz = V(3);
% ������ϵW
vec_Pt2P1 = P1 - Pt2;
vec_W_ = cross(vec_Pt1P1, vec_Pt2P1);
W_ = sqrt(power(vec_W_(1), 2) + power(vec_W_(2), 2) + power(vec_W_(3), 2));
W = (1/W_) * vec_W_;
ax = W(1); ay = W(2); az = W(3);
% ������ϵU
U = cross(V, W);
nx = U(1); ny = U(2); nz = U(3);
% ����ڻ�����ϵ{O-XYZ}�� ������ϵ{C-UVW}������任����
T = [nx ox ax Pt1(1);
     ny oy ay Pt1(2);
     nz oz az Pt1(3);
      0  0  0  1];

% ����������Ԫ��֮��ļн�
dot_q = Qt1.s*Qt2.s + Qt1.v(1)*Qt2.v(1) + Qt1.v(2)*Qt2.v(2) + Qt1.v(3)*Qt2.v(3);
if (dot_q < 0)
    dot_q = -dot_q;
end
% �岹ʱ��
Tt = d / vt;
i = 1;
for j = 0: t: Tt
    % λ�ò岹
    x_(i) = r -  r * cos(vt*j/r);
    y_(i) = r * sin(vt*j/r);
    P = T*[x_(i); y_(i); 0; 1];
    x(i) = P(1);
    y(i) = P(2);
    z(i) = P(3);
    % ��λ��Ԫ������������̬�岹
    % ��ֵ����Ԫ��
    if (dot_q > 0.9995)
        k0 = 1-t;
        k1 = t;
    else
        sin_t = sqrt(1 - power(dot_q, 2));
        omega = atan2(sin_t, dot_q);
        k0 = sin((1-t)*omega) / sin(omega);
        k1 = sin(t*omega) / sin(omega);
    end
    qk(i) = Qt1 * k0 + Qt2 * k1;
    N = i;
    i = i + 1;
end

end