% 轨迹规划中，首先建立机器人模型，6R机器人模型，名称Six_Link。
    L1 = Link([0  0            0      0],    'modified');
    L2 = Link([0  0.138+0.024  0     -pi/2], 'modified');
    L3 = Link([0 -0.127-0.024  0.420  0],    'modified');
    L4 = Link([0  0.114+0.021  0.375  0],    'modified');
    L5 = Link([0  0.114+0.021  0     -pi/2], 'modified');
    L6 = Link([0  0.090+0.021  0      pi/2], 'modified');
    Six_Link = SerialLink([L1,L2,L3,L4,L5,L6]);
    Six_Link.display();
% 定义轨迹规划中初始关节角度（First_Theta）和终止关节角度（Final_Theta）、步数777。
% jtraj函数
    First_Theta = [0 -pi/2 pi/6 pi/4 pi/6 pi/3];
    Final_Theta = [pi/4,-pi/3,pi/5,pi/2,-pi/4,pi/6];
    step = 777;
    [q,qd,qdd] = jtraj(First_Theta,Final_Theta,step);

%平面中一共分成2*4=8个子画图区间，一共两行，每行四个
%在第一行第1个子图画位置信息。
    subplot(2,4,1);
    i = 1:6;
    plot(q(:,i)); grid on;
    title('位置');
%在第一行第2个子图画速度信息。
    subplot(2,4,2);
    i = 1:6;
    plot(qd(:,i));grid on;
    title('速度');
%在第二行第1个子图画加速度信息。
    subplot(2,4,5);
    i = 1:6;
    plot(qdd(:,i));grid on;
    title('加速度');

%根据First_Theta和Final_Theta得到起始和终止的位姿矩阵。
    T0 = Six_Link.fkine(First_Theta);
    Tf = Six_Link.fkine(Final_Theta);
%利用ctraj在笛卡尔空间规划轨迹。
    Tc = ctraj(T0,Tf,step);         
%在齐次旋转矩阵中提取移动变量，相当于笛卡尔坐标系的点的位置。
    Tjtraj = transl(Tc);            
%在第二行第2个子图画p1到p2直线轨迹。
    subplot(2,4,6);
    plot2(Tjtraj,'r');grid on;
    title('TO到Tf直线轨迹');
   
%     hold on;
%在第一行三四子图和第二行三四子图，就相当于整个的右半部分画图
    subplot(2,4,[3,4,7,8]);
%动图
for Var = 1:777
 qq(:,Var) = Inverse_Kinematics(  Tc(:,:,Var)  );
end
 Six_Link.plot(qq');






