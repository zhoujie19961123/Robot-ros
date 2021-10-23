% �켣�滮�У����Ƚ���������ģ�ͣ�6R������ģ�ͣ�����Six_Link
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
   tt=Six_Link.fkine([pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0]);
%     Six_Link.fkine([theta1,theta2,theta3,theta4,theta5,theta6]);

   tt=[    0.8660   -0.0000   -0.5000    0.0689
           0.2500   -0.8660    0.4330    0.5275
          -0.4330   -0.5000   -0.7500    0.1214
             0         0         0      1.0000];
   Six_Link.teach()
   
   
% ����켣�滮�г�ʼ�ؽڽǶȣ�First_Theta������ֹ�ؽڽǶȣ�Final_Theta��������777��
% jtraj����(������ζ���ʽ�滮�켣),����Ϊ���ؽڽǶ�
 %ctraj(�����ȼ����ȼ��ٹ滮�켣)������Ϊ���λ�˾���
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
    step = 777;
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

%����First_Theta��Final_Theta�õ���ʼ����ֹ��λ�˾���
    T0 = Six_Link.fkine(First_Theta);
    Tf = Six_Link.fkine(Final_Theta);
%����ctraj�ڵѿ����ռ�滮�켣��
    Tc = ctraj(T0,Tf,step);         
%�������ת��������ȡ�ƶ��������൱�ڵѿ�������ϵ�ĵ��λ�á�
    Tjtraj = transl(Tc);            
%�ڵڶ��е�2����ͼ��p1��p2ֱ�߹켣��
    subplot(2,4,6);
    plot2(Tjtraj,'r');grid on;
    title('TO��Tfֱ�߹켣');
    %     hold on;
%�ڵ�һ��������ͼ�͵ڶ���������ͼ�����൱���������Ұ벿�ֻ�ͼ
    subplot(2,4,[3,4,7,8]);
%��ͼ
for Var = 1:500
    %����������
 wwww(:,Var) = GTC50_ikine5(1,Tc(:,:,Var));
end
plot2(Tjtraj,'r');grid on;
%TTT=fkine(q);
%plot3(squeeze(TTT(1,4,:)),squeeze(Tc(2,4,:)),squeeze(Tc(4,4,:)));%��ȡ�켣
%hold on
 Six_Link.plot(wwww')
 

   
   
