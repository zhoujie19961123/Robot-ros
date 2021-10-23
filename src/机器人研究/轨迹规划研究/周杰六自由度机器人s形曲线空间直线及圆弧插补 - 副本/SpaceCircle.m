% �ռ�Բ��λ�ò岹��RPY����̬�岹 + ���μӼ��ٹ�һ������
% ������ ���Sλ�ú�RPY��, �м��Mλ��, �յ�Dλ�ú�RPY�ǣ�ĩ�˽��ٶȣ��ǼӼ��ٶ�
% ������������ٶȺͽǼ��ٶȾ�Ϊ�Ƕ���
function [x,y,z,alp,beta,gama,N] = SpaceCircle(S, M, D, S_, D_, ws, a)
x1 = S(1); x2 = M(1); x3 = D(1);
y1 = S(2); y2 = M(2); y3 = D(2);
z1 = S(3); z2 = M(3); z3 = D(3);
alp1 = S_(1); beta1 = S_(2); gama1 = S_(3);
alp2 = D_(1); beta2 = D_(2); gama2 = D_(3);
%���Բһ�㷽��
A1 = (y1 - y3)*(z2 - z3) - (y2 - y3)*(z1 - z3);
B1 = (x2 - x3)*(z1 - z3) - (x1 - x3)*(z2 - z3);
C1 = (x1 - x3)*(y2 - y3) - (x2 - x3)*(y1 - y3);
D1 = -(A1*x3 + B1*y3 + C1*z3);
%p2p3��ֱƽ����
A2 = x2 - x1;
B2 = y2 - y1;
C2 = z2 - z1;
D2 = -((x2^2 - x1^2) + (y2^2 - y1^2) + (z2^2 - z1^2)) / 2;
%p1p2��ֱƽ����
A3 = x3 - x2;
B3 = y3 - y2;
C3 = z3 - z2;
D3 = -((x3^2 - x2^2) + (y3^2 - y2^2) + (z3^2 - z2^2)) / 2;
A = [A1, B1, C1; A2, B2, C2; A3, B3, C3];
b = [-D1, -D2, -D3]';
% ��Բ������,���н�����²��ø�˹����Ԫ��ȥ��
C = Gauss_lie(3, A, b);
x0 = C(1); y0 = C(2); z0 = C(3);
plot3(x0, y0, z0, 'bo')
hold on
% ���Բ�뾶
r = sqrt(power(x1 - x0, 2) + power(y1 - y0, 2) + power(z1 - z0, 2));
% ������ϵZ0�ķ�������
L = sqrt(A1^2 + B1^2 + C1^2);
ax = A1 / L; ay = B1 / L; az = C1 / L;
% ������ϵX0�ķ�������
nx = (x1 - x0) / r;
ny = (y1 - y0) / r;
nz = (z1 - z0) / r;
% ������ϵY0�ķ������ң�cross�������A��B
o = cross([ax, ay, az], [nx, ny, nz]);
ox = o(1);
oy = o(2);
oz = o(3);
% ����ڻ�����ϵ{O-XYZ}�� ������ϵ{C-X0Y0Z0}������任����
T = [nx ox ax x0;
     ny oy ay y0;
     nz oz az z0;
      0  0  0  1];
%T_ni = T^-1;
% ����������ϵ{C-X0Y0Z0}��S��M��D������
S_ = (T^-1)*[S'; 1];
M_ = (T^-1)*[M'; 1];
D_ = (T^-1)*[D'; 1];
x1_ = S_(1) ; y1_ = S_(2); z1_ = S_(3);
x2_ = M_(1); y2_ = M_(2); z2_ = M_(3);
x3_ = D_(1); y3_ = D_(2); z3_ = D_(3);
% �ж�Բ����˳ʱ�뻹����ʱ�룬�����Բ�Ľ�
if (atan2(y2_, x2_) < 0)
    angle_SOM = atan2(y2_, x2_) + 2*pi;
else
    angle_SOM = atan2(y2_, x2_);
end
if (atan2(y3_, x3_) < 0)
    angle_SOD = atan2(y3_, x3_) + 2*pi;
else
    angle_SOD = atan2(y3_, x3_);
end
% ��ʱ��
if (angle_SOM < angle_SOD)
    flag = 1;
    theta = angle_SOD; % Բ�Ľ�
end
% ˳ʱ��
if (angle_SOM >= angle_SOD)
    flag = -1;
    theta = 2*pi - angle_SOD; % Բ�Ľ�
end

% �岹����N
P = 2; %�岹���������Ӳ�ֵ�����������С
ws = ws*pi / 180; % �ǶȻ��ɻ���
a = a*pi / 180;
N = P*theta / ws;
% ���һ������
lambda = Normalization(theta, ws, a, N);

% �岹ԭ��: ����ƽ���Ͻ��в岹���򻯣�
% ��������ϵ��z1_,z2_,z3_��Ϊ0�������Բ��������ϵ��XOYƽ����
% ��ʱת��Ϊƽ��Բ���岹����
delta_ang = theta;
delta_alp = alp2 - alp1;
delta_beta = beta2 - beta1;
delta_gama = gama2 - gama1;
for i = 1: N+1
    x_(i) = flag * r * cos(lambda(i)*delta_ang);
    y_(i) = flag * r * sin(lambda(i)*delta_ang);
    P = T*[x_(i); y_(i); 0; 1];
    x(i) = P(1);
    y(i) = P(2);
    z(i) = P(3);
    alp(i) = alp1 + delta_alp*lambda(i);
    beta(i) = beta1 + delta_beta*lambda(i);
    gama(i) = gama1 + delta_gama*lambda(i);
end
% % figure(1)
% % plot(x_, y_)
% �岹ԭ�� ��ԭԲ���Ͻ��в岹
% Բ������һ�㴦��ǰ�������������
% x(1) = x1; y(1) = y1; z(1) = z1;
% for i = 1: N+1
%     m(i) = flag*(ay*(z(i) - z0) - az*(y(i) - y0));
%     n(i) = flag*(az*(x(i) - x0) - ax*(z(i) - z0));
%     l(i) = flag*(ax*(y(i) - y0) - ay*(x(i) - x0));
%     delta_s = delta_ang * r;
%     E = delta_s / (r*sqrt(ax^2 + ay^2 + az^2));
%     G = r / sqrt(r^2 + delta_s^2);
%     x(i+1) = x0 + G*(x(i) + E*m(i) - x0);
%     y(i+1) = y0 + G*(y(i) + E*n(i) - y0);
%     z(i+1) = z0 + G*(z(i) + E*l(i) - z0);
% end 

end
