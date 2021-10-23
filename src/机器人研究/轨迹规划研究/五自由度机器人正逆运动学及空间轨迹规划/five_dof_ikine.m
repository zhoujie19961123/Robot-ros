%5���ɶ�������
function ik_T = five_dof_ikine(fk_T)
a2 = 0.104; a3 = 0.096; ae = 0.028; de = 0.163; % ae��de��Ϊa7��d7

nx = fk_T(1, 1); ox = fk_T(1, 2); ax = fk_T(1, 3); px = fk_T(1, 4);
ny = fk_T(2, 1); oy = fk_T(2, 2); ay = fk_T(2, 3); py = fk_T(2, 4);
nz = fk_T(3, 1); oz = fk_T(3, 2); az = fk_T(3, 3); pz = fk_T(3, 4);

% theta1
theta1 = atan2(py - ny*ae - ay*de, px - nx*ae - ax*de);
% theta5
theta5 = atan2(sin(theta1)*nx - cos(theta1)*ny, sin(theta1)*ox - cos(theta1)*oy);
% theta3��������
m = px - nx*ae - ax*de;
n = py - ny*ae - ay*de;
t = pz - nz*ae - az*de;
c3 = (power(cos(theta1), 2)*power(m, 2) + power(sin(theta1), 2)*power(n, 2) + 2*sin(theta1)*cos(theta1)*m*n + power(t, 2) - power(a2, 2) - power(a3, 2)) / (2*a2*a3);
theta3_1 = atan2(sqrt(1-power(c3, 2)), c3);
theta3_2 = atan2(-sqrt(1-power(c3, 2)), c3);
% theta2��������
% ��Ӧtheta3_1
c2_1 = ((a3*cos(theta3_1) + a2)*(cos(theta1)*m + sin(theta1)*n) + a3*sin(theta3_1)*t) / (power(a3*cos(theta3_1) + a2, 2) + power(a3, 2)*power(sin(theta3_1), 2));
s2_1 = ((a3*cos(theta3_1) + a2)*t - a3*sin(theta3_1)*(cos(theta1)*m + sin(theta1)*n)) / (power(a3*cos(theta3_1) + a2, 2) + power(a3, 2)*power(sin(theta3_1), 2));
% ��Ӧtheta3_2
c2_2 = ((a3*cos(theta3_2) + a2)*(cos(theta1)*m + sin(theta1)*n) + a3*sin(theta3_2)*t) / (power(a3*cos(theta3_2) + a2, 2) + power(a3, 2)*power(sin(theta3_2), 2));
s2_2 = ((a3*cos(theta3_2) + a2)*t - a3*sin(theta3_2)*(cos(theta1)*m + sin(theta1)*n)) / (power(a3*cos(theta3_2) + a2, 2) + power(a3, 2)*power(sin(theta3_2), 2));
theta2_1 = atan2(s2_1, c2_1);
theta2_2 = atan2(s2_2, c2_2);
% theta4��������
theta4_1 = atan2(az, cos(theta1)*ax + sin(theta1)*ay) - theta3_1 - theta2_1;
theta4_2 = atan2(az, cos(theta1)*ax + sin(theta1)*ay) - theta3_2 - theta2_2;

% ik_T = [theta1, theta2_1, theta3_1, theta4_1, theta5;
%         theta1, theta2_2, theta3_2, theta4_2, theta5];

%ik_T = [theta1, theta2_1, theta3_1, theta4_1, pi/2,theta5,0];
ik_T = [theta1, theta2_2, theta3_2, theta4_2, pi/2,theta5,0];
end
