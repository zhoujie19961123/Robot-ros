%% 轨迹规划中，首先建立机器人模型，6R机器人模型，名称Six_Link
%六轴机器人，采用自己编写的正逆解程序及s曲线进行轨迹规划
%             theta     d        a        alpha       offset 
    L1 = Link([0        0.1065       0         pi/2],     'standard');
    L2 = Link([0         0       -0.408           0],    'standard');
    L3 = Link([0         0       -0.382           0],    'standard');
    L4 = Link([0         0.1109      0         pi/2],    'standard');
    L5 = Link([0         0.1109      0        -pi/2], 'standard'); 
    L6 = Link([0         0.08409      0            0],  'standard');
   %正逆运动学 
   Six_Link = SerialLink([L1,L2,L3,L4,L5,L6]);
   Six_Link.plot([pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0]);
   %Six_Link.fkine([pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0]);
   %Six_Link.fkine([theta1,theta2,theta3,theta4,theta5,theta6]);

   tt=[    0.8660   -0.0000   -0.5000    0.0689
           0.2500   -0.8660    0.4330    0.5275
          -0.4330   -0.5000   -0.7500    0.1214
             0         0         0      1.0000];
   Six_Link.teach()
   
   
%% 定义轨迹规划中初始关节角度（First_Theta）和终止关节角度（Final_Theta）、步数777。
% jtraj函数(利用五次多项式规划轨迹),输入为各关节角度
 %ctraj(利用匀加速匀减速规划轨迹)，输入为点的位姿矩阵
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
    %step = 777;
    %采样时间为0.01s,规划总时间为10S
    %[q,qd,qdd] = jtraj(First_Theta,Final_Theta,step);
    %[q,qd,qdd] = ctraj(First_Theta,Final_Theta,step);
    %关节空间轨迹规划
    [q,qd,qdd,qddd,time_max]=STrajectoryfunction(First_Theta,Final_Theta);
        q_new=q';
        qd_new=qd';
        qdd_new=qdd';
        qddd_new=qddd';

%平面中一共分成2*4=8个子画图区间，一共两行，每行四个
%在第一行第1个子图画位置信息。
    subplot(2,4,1);
    i = 1:6;
    plot(0:0.001:time_max,q_new(:,i), 'LineWidth', 1.5)
    title('关节角(°)')
%在第一行第2个子图画速度信息。
    subplot(2,4,2);
    i = 1:6;
    plot(0:0.001:time_max,qd_new(:,i), 'LineWidth', 1.5)
    title('角速度(°/s)')
%在第二行第1个子图画加速度信息。
    subplot(2,4,3);
    i = 1:6;
    plot(0:0.001:time_max,qdd_new(:,i), 'LineWidth', 1.5)
    title('角加速度(°/s^2)')
    subplot(2,4,4);
    i = 1:6;
    plot(0:0.001:time_max,qddd_new(:,i), 'LineWidth', 1.5)

%% 自己编写的空间直线插补程序
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
%根据First_Theta和Final_Theta得到起始和终止的位姿矩阵。
    T_S = Six_Link.fkine(First_Theta);
    T_D =Six_Link.fkine(Final_Theta);
%     GTC50_ikine5(1,T_S)*180/pi
%     GTC50_ikine5(1,T_D)*180/pi
%     Six_Link.fkine(GTC50_ikine5(1,T_D)*180/pi)
%利用SpaceLine在笛卡尔空间规划轨迹。
    S = T_S(1: 3, 4); % 起点对应的位置坐标
    D = T_D(1: 3, 4); % 终点对应的位置坐标
    vs = 0.06; a = 0.02; % 直线插补速度参数
    [S_RPY(1),S_RPY(2),S_RPY(3)] = RPY_angle(T_S); % 起点对应的RPY角
    [D_RPY(1),D_RPY(2),D_RPY(3)] = RPY_angle(T_D); % 终点对应的RPY角
    [x,y,z,alp,beta,gama,N] = SpaceLine(S, D, S_RPY, D_RPY, vs, a); % 直线插补，得到插值点（不包括起点和终点）
    plot3(x, y, z)
    hold on
    th1(1) = First_Theta(1); th2(1) = First_Theta(2); th3(1) = First_Theta(3);
    th4(1) = First_Theta(4); th5(1) = First_Theta(5); th6(1) = First_Theta(6); 
%将得到的各空间点及其位姿进行逆运动学解算
T = {1, N};
for i = 1: N+1
    R = RPY_rot(alp(i), beta(i), gama(i));%将RPY转化为3*3矩阵
    R(1, 1:3);%R第一行
    R(2, 1:3);%R第二行
    R(3, 1:3);%R第三行
    T{i} = [R(1, 1:3), x(i);
            R(2, 1:3), y(i);
            R(3, 1:3), z(i);
            0 0 0 1];
     %这人的逆解程序有问题
     theta = GTC50_ikine5(1,T{i});
     th = theta(1, 1:6); % 简单取1行逆解
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


%% 自己编写的空间圆弧插补程序
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,     2*pi/3,  0];
    Midear_Theta = [pi,    -pi/3, pi/3, pi/3,    pi/4,  pi/3];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
    T_S = Six_Link.fkine(First_Theta);    %起点末端执行器位姿
    T_M = Six_Link.fkine(Midear_Theta);
    T_D = Six_Link.fkine(Final_Theta);
    ws = 5; a = 2.5; % 空间圆弧插补速度参数
    [S_RPY(1),S_RPY(2),S_RPY(3)] = RPY_angle(T_S); % 起点对应的RPY角
    [D_RPY(1),D_RPY(2),D_RPY(3)] = RPY_angle(T_D); % 终点对应的RPY角
    S = T_S(1: 3, 4); % 起点对应的位置坐标
    M = T_M(1: 3, 4);%中间点
    D = T_D(1: 3, 4); % 终点对应的位置坐标
    
    [x,y,z,alp,beta,gama,N] = SpaceCircle(S', M', D', S_RPY, D_RPY, ws, a);%圆弧插补
    plot3(x, y, z)
    hold on
    th1(1) = First_Theta(1); th2(1) = First_Theta(2); th3(1) = First_Theta(3);
    th4(1) = First_Theta(4); th5(1) = First_Theta(5); th6(1) = First_Theta(6); 
    %将得到的各空间点及其位姿进行逆运动学解算
T = {1, N};
for i = 1: N+1
    R = RPY_rot(alp(i), beta(i), gama(i));%将RPY转化为3*3矩阵
    R(1, 1:3);%R第一行
    R(2, 1:3);%R第二行
    R(3, 1:3);%R第三行
    T{i} = [R(1, 1:3), x(i);
            R(2, 1:3), y(i);
            R(3, 1:3), z(i);
            0 0 0 1];
     %这人的逆解程序有问题
     theta = GTC50_ikine5(1,T{i});
     th = theta(1, 1:6); % 简单取1行逆解
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
 title('关节角(rad/s)')
   
