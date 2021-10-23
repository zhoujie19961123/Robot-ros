%Bվ5���ɶȻ����˿ռ�켣�滮��
% Standard DH
% five_dof robot
% �ڹؽ�4�͹ؽ�5֮������һ������ؽڣ��������˶�ѧ����
clear;
clc;
th(1) = 0; d(1) = 0; a(1) = 0; alp(1) = pi/2;
th(2) = 0; d(2) = 0; a(2) = 1.04;alp(2) = 0;
th(3) = 0; d(3) = 0; a(3) = 0.96; alp(3) = 0;
th(4) = 0; d(4) = 0; a(4) = 0; alp(4) = 0;
th(5) = pi/2; d(5) = 0; a(5) = 0; alp(5) = pi/2;
th(6) = 0; d(6) = 0; a(6) = 0; alp(6) = 0;
th(7) = 0; d(7) = 1.63; a(7) = 0.28; alp(7) = 0;
% DH parameters  th     d    a    alpha  sigma
L1 = Link([th(1), d(1), a(1), alp(1), 0]);
L2 = Link([th(2), d(2), a(2), alp(2), 0]);
L3 = Link([th(3), d(3), a(3), alp(3), 0]);
L4 = Link([th(4), d(4), a(4), alp(4), 0]);
L5 = Link([th(5), d(5), a(5), alp(5), 0]); 
L6 = Link([th(6), d(6), a(6), alp(6), 0]);
L7 = Link([th(7), d(7), a(7), alp(7), 0]);
robot = SerialLink([L1, L2, L3, L4, L5, L6, L7]); 
robot.name='MyRobot-5-dof';
robot.display() 

% ���ؽڽ�[0 90 30 60 90 0 0]*pi/180
% �յ�ؽڽ�[0 90 60 60 90 0 0]*pi/180
theta_S = [0 120 100 40 90 0 0]*pi/180;
theta_M = [60 100 100 30 90 0 0]*pi/180;
theta_D = [100 120 100 40 90 0 0]*pi/180;
% robot.teach();
% robot.plot(theta_D); 
% hold on
T_S = robot.fkine(theta_S);    %���ĩ��ִ����λ��
T_M = robot.fkine(theta_M);
T_D = robot.fkine(theta_D);
% ik_T = five_dof_ikine(T_D)
[S_RPY(1),S_RPY(2),S_RPY(3)] = RPY_angle(T_S); % ����Ӧ��RPY��
[D_RPY(1),D_RPY(2),D_RPY(3)] = RPY_angle(T_D); % �յ��Ӧ��RPY��
S = T_S(1: 3, 4); % ����Ӧ��λ������
M = T_M(1: 3, 4);%�м��
D = T_D(1: 3, 4); % �յ��Ӧ��λ������
%vs = 0.06; a = 0.02; % ֱ�߲岹�ٶȲ���
ws = 5; a = 2.5; % �ռ�Բ���岹�ٶȲ���
% [x,y,z,alp,beta,gama,N] = SpaceLine(S, D, S_RPY, D_RPY, vs, a); % ֱ�߲岹���õ���ֵ�㣨�����������յ㣩
[x,y,z,alp,beta,gama,N] = SpaceCircle(S', M', D', S_RPY, D_RPY, ws, a);
plot3(x, y, z)
hold on
th1(1) = theta_S(1); th2(1) = theta_S(2); th3(1) = theta_S(3);
th4(1) = theta_S(4); th5(1) = theta_S(5); th6(1) = theta_S(6); th7(1) = theta_S(7);
% t = [0 0 0 0 0];
%T = {1, N};
for i = 1: N+1
    R = RPY_rot(alp(i), beta(i), gama(i));%��RPYת��Ϊ3*3����
    R(1, 1:3);%R��һ��
    R(2, 1:3);%R�ڶ���
    R(3, 1:3);%R������
    T{i} = [R(1, 1:3), x(i);
            R(2, 1:3), y(i);
            R(3, 1:3), z(i);
            0 0 0 1];
        %���˵�������������
     theta = five_dof_ikine(T{i});
     th = theta(2, 1:5); % ��ȡ1�����
     th1(i+1) = th(1);
     th2(i+1) = th(2);
     th3(i+1) = th(3);
     th4(i+1) = th(4);
     th5(i+1) = pi/2;
     th6(i+1) = th(5);
     th7(i+1) = 0;
end
for i = 1: N+1
    T_ = robot.fkine([th1(i), th2(i), th3(i), th4(i), th5(i), th6(i), th7(i)]);
    traj = T_(1: 3, 4);
    a(i) = traj(1);
    b(i) = traj(2);
    c(i) = traj(3);
    plot3(traj(1), traj(2), traj(3), 'r*');
    hold on
    robot.plot([th1(i), th2(i), th3(i), th4(i), th5(i), th6(i), th7(i)])
end
