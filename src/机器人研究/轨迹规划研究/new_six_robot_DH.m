% 轨迹规划中，首先建立机器人模型，6R机器人模型，名称Six_Link。
%GTC50  标准的DH建立的可以使用
%抓具末端相对于末端坐标系的位置为[0,-0.0303,0.9921]
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
   Six_Link.teach()
   %Six_Link.fkine([pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0]);
      tt=[ 0.8660   -0.0000   -0.5000    0.0689
           0.2500   -0.8660    0.4330    0.5275
          -0.4330   -0.5000   -0.7500    0.1214
             0         0         0      1.0000];
   q=GTC50_fkine5(7,tt);
   i = 1:6;
   theta(i)=q(1,:);
   Six_Link.fkine(theta(i))

   
   
% 定义轨迹规划中初始关节角度（First_Theta）和终止关节角度（Final_Theta）、步数777。
% jtraj函数(利用五次多项式规划轨迹),输入为各关节角度
 %ctraj(利用匀加速匀减速规划轨迹)，输入为点的位姿矩阵
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [pi,-pi/3,-pi/3,0,pi/3,pi/2];
    %step = 777;
    step = 500;%采样时间为0.01s,规划总时间为10S
    [q,qd,qdd] = jtraj(First_Theta,Final_Theta,step);
    %[q,qd,qdd] = ctraj(First_Theta,Final_Theta,step);
  

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
    plot2(Tjtraj,'b');grid on;
    title('TO到Tf直线轨迹');
    %     hold on;
%在第一行三四子图和第二行三四子图，就相当于整个的右半部分画图
    subplot(2,4,[3,4,7,8]);
%动图
for Var = 1:500
    %调用逆解程序
 wwww(:,Var) = GTC50_ikine5(1,Tc(:,:,Var));
end
plot2(Tjtraj,'r');grid on;
%TTT=fkine(q);
%plot3(squeeze(TTT(1,4,:)),squeeze(Tc(2,4,:)),squeeze(Tc(4,4,:)));%提取轨迹
%hold on
 Six_Link.plot(wwww')