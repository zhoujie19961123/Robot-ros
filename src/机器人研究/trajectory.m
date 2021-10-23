% �켣�滮�У����Ƚ���������ģ�ͣ�6R������ģ�ͣ�����Six_Link��
    L1 = Link([0  0            0      0],    'modified');
    L2 = Link([0  0.138+0.024  0     -pi/2], 'modified');
    L3 = Link([0 -0.127-0.024  0.420  0],    'modified');
    L4 = Link([0  0.114+0.021  0.375  0],    'modified');
    L5 = Link([0  0.114+0.021  0     -pi/2], 'modified');
    L6 = Link([0  0.090+0.021  0      pi/2], 'modified');
    Six_Link = SerialLink([L1,L2,L3,L4,L5,L6]);
    Six_Link.display();
% ����켣�滮�г�ʼ�ؽڽǶȣ�First_Theta������ֹ�ؽڽǶȣ�Final_Theta��������777��
% jtraj����
    First_Theta = [0 -pi/2 pi/6 pi/4 pi/6 pi/3];
    Final_Theta = [pi/4,-pi/3,pi/5,pi/2,-pi/4,pi/6];
    step = 777;
    [q,qd,qdd] = jtraj(First_Theta,Final_Theta,step);

%ƽ����һ���ֳ�2*4=8���ӻ�ͼ���䣬һ�����У�ÿ���ĸ�
%�ڵ�һ�е�1����ͼ��λ����Ϣ��
    subplot(2,4,1);
    i = 1:6;
    plot(q(:,i)); grid on;
    title('λ��');
%�ڵ�һ�е�2����ͼ���ٶ���Ϣ��
    subplot(2,4,2);
    i = 1:6;
    plot(qd(:,i));grid on;
    title('�ٶ�');
%�ڵڶ��е�1����ͼ�����ٶ���Ϣ��
    subplot(2,4,5);
    i = 1:6;
    plot(qdd(:,i));grid on;
    title('���ٶ�');

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
for Var = 1:777
 qq(:,Var) = Inverse_Kinematics(  Tc(:,:,Var)  );
end
 Six_Link.plot(qq');






