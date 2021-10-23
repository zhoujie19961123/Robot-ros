%% �켣�滮�У����Ƚ���������ģ�ͣ�6R������ģ�ͣ�����Six_Link
%��������ˣ������Լ���д����������s���߽��й켣�滮
%             theta     d        a        alpha       offset 
    L1 = Link([0        0.1065       0         pi/2],     'standard');
    L2 = Link([0         0       -0.408           0],    'standard');
    L3 = Link([0         0       -0.382           0],    'standard');
    L4 = Link([0         0.1109      0         pi/2],    'standard');
    L5 = Link([0         0.1109      0        -pi/2], 'standard'); 
    L6 = Link([0         0.08409      0            0],  'standard');
   %�����˶�ѧ 
   Six_Link = SerialLink([L1,L2,L3,L4,L5,L6]);
   Six_Link.plot([pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0]);
   %Six_Link.fkine([pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0]);
   %Six_Link.fkine([theta1,theta2,theta3,theta4,theta5,theta6]);

   tt=[    0.8660   -0.0000   -0.5000    0.0689
           0.2500   -0.8660    0.4330    0.5275
          -0.4330   -0.5000   -0.7500    0.1214
             0         0         0      1.0000];
   Six_Link.teach()
   
   
%% ����켣�滮�г�ʼ�ؽڽǶȣ�First_Theta������ֹ�ؽڽǶȣ�Final_Theta��������777��
% jtraj����(������ζ���ʽ�滮�켣),����Ϊ���ؽڽǶ�
 %ctraj(�����ȼ����ȼ��ٹ滮�켣)������Ϊ���λ�˾���
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
    %step = 777;
    %����ʱ��Ϊ0.01s,�滮��ʱ��Ϊ10S
    %[q,qd,qdd] = jtraj(First_Theta,Final_Theta,step);
    %[q,qd,qdd] = ctraj(First_Theta,Final_Theta,step);
    %�ؽڿռ�켣�滮
    [q,qd,qdd,qddd,time_max]=STrajectoryfunction(First_Theta,Final_Theta);
        q_new=q';
        qd_new=qd';
        qdd_new=qdd';
        qddd_new=qddd';

%ƽ����һ���ֳ�2*4=8���ӻ�ͼ���䣬һ�����У�ÿ���ĸ�
%�ڵ�һ�е�1����ͼ��λ����Ϣ��
    subplot(2,4,1);
    i = 1:6;
    plot(0:0.001:time_max,q_new(:,i), 'LineWidth', 1.5)
    title('�ؽڽ�(��)')
%�ڵ�һ�е�2����ͼ���ٶ���Ϣ��
    subplot(2,4,2);
    i = 1:6;
    plot(0:0.001:time_max,qd_new(:,i), 'LineWidth', 1.5)
    title('���ٶ�(��/s)')
%�ڵڶ��е�1����ͼ�����ٶ���Ϣ��
    subplot(2,4,3);
    i = 1:6;
    plot(0:0.001:time_max,qdd_new(:,i), 'LineWidth', 1.5)
    title('�Ǽ��ٶ�(��/s^2)')
    subplot(2,4,4);
    i = 1:6;
    plot(0:0.001:time_max,qddd_new(:,i), 'LineWidth', 1.5)

%% �Լ���д�Ŀռ�ֱ�߲岹����
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
%����First_Theta��Final_Theta�õ���ʼ����ֹ��λ�˾���
    T_S = Six_Link.fkine(First_Theta);
    T_D =Six_Link.fkine(Final_Theta);
%     GTC50_ikine5(1,T_S)*180/pi
%     GTC50_ikine5(1,T_D)*180/pi
%     Six_Link.fkine(GTC50_ikine5(1,T_D)*180/pi)
%����SpaceLine�ڵѿ����ռ�滮�켣��
    S = T_S(1: 3, 4); % ����Ӧ��λ������
    D = T_D(1: 3, 4); % �յ��Ӧ��λ������
    vs = 0.06; a = 0.02; % ֱ�߲岹�ٶȲ���
    [S_RPY(1),S_RPY(2),S_RPY(3)] = RPY_angle(T_S); % ����Ӧ��RPY��
    [D_RPY(1),D_RPY(2),D_RPY(3)] = RPY_angle(T_D); % �յ��Ӧ��RPY��
    [x,y,z,alp,beta,gama,N] = SpaceLine(S, D, S_RPY, D_RPY, vs, a); % ֱ�߲岹���õ���ֵ�㣨�����������յ㣩
    plot3(x, y, z)
    hold on
    th1(1) = First_Theta(1); th2(1) = First_Theta(2); th3(1) = First_Theta(3);
    th4(1) = First_Theta(4); th5(1) = First_Theta(5); th6(1) = First_Theta(6); 
%���õ��ĸ��ռ�㼰��λ�˽������˶�ѧ����
T = {1, N};
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
     theta = GTC50_ikine5(1,T{i});
     th = theta(1, 1:6); % ��ȡ1�����
     th1(i+1) = th(1);
     th2(i+1) = th(2);
     th3(i+1) = th(3);
     th4(i+1) = th(4);
     th5(i+1) = th(5);
     th6(i+1) = th(6);
end
for i = 1: N+1
    T_ = Six_Link.fkine([th1(i), th2(i), th3(i), th4(i), th5(i), th6(i)]);
    traj = T_(1: 3, 4);
    a(i) = traj(1);
    b(i) = traj(2);
    c(i) = traj(3);
    plot3(traj(1), traj(2), traj(3), 'r*');
    hold on
    Six_Link.plot([th1(i), th2(i), th3(i), th4(i), th5(i), th6(i)])
    axis([-1 1 -1 1 -1 1])
end


%% �Լ���д�Ŀռ�Բ���岹����
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,     2*pi/3,  0];
    Midear_Theta = [pi,    -pi/3, pi/3, pi/3,    pi/4,  pi/3];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
    T_S = Six_Link.fkine(First_Theta);    %���ĩ��ִ����λ��
    T_M = Six_Link.fkine(Midear_Theta);
    T_D = Six_Link.fkine(Final_Theta);
    ws = 5; a = 2.5; % �ռ�Բ���岹�ٶȲ���
    [S_RPY(1),S_RPY(2),S_RPY(3)] = RPY_angle(T_S); % ����Ӧ��RPY��
    [D_RPY(1),D_RPY(2),D_RPY(3)] = RPY_angle(T_D); % �յ��Ӧ��RPY��
    S = T_S(1: 3, 4); % ����Ӧ��λ������
    M = T_M(1: 3, 4);%�м��
    D = T_D(1: 3, 4); % �յ��Ӧ��λ������
    
    [x,y,z,alp,beta,gama,N] = SpaceCircle(S', M', D', S_RPY, D_RPY, ws, a);%Բ���岹
    plot3(x, y, z)
    hold on
    th1(1) = First_Theta(1); th2(1) = First_Theta(2); th3(1) = First_Theta(3);
    th4(1) = First_Theta(4); th5(1) = First_Theta(5); th6(1) = First_Theta(6); 
    %���õ��ĸ��ռ�㼰��λ�˽������˶�ѧ����
T = {1, N};
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
     theta = GTC50_ikine5(1,T{i});
     th = theta(1, 1:6); % ��ȡ1�����
     th1(i+1) = th(1);
     th2(i+1) = th(2);
     th3(i+1) = th(3);
     th4(i+1) = th(4);
     th5(i+1) = th(5);
     th6(i+1) = th(6);
end
subplot(1,2,1);
for i = 1: N+1
    T_ = Six_Link.fkine([th1(i), th2(i), th3(i), th4(i), th5(i), th6(i)]);
    traj = T_(1: 3, 4);
    a(i) = traj(1);
    b(i) = traj(2);
    c(i) = traj(3);
    plot3(traj(1), traj(2), traj(3), 'r*');
    hold on
    Six_Link.plot([th1(i), th2(i), th3(i), th4(i), th5(i), th6(i)]);grid on;
    axis([-1 1 -1 1 -1 1])
    
end
subplot(1,2,2);
time_all=0:0.1:9.9;
time=time_all';
th_all=[th1',th2',th3',th4',th5',th6'];
 plot(time,th_all ,'LineWidth', 1.5);grid on;
 title('�ؽڽ�(rad/s)')
   
