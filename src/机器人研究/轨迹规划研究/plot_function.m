%�Լ���д�������ɶȻ�����s���߹켣�滮����
    First_Theta = [pi/2,-2*pi/3,-2*pi/3,0,2*pi/3,0];
    Final_Theta = [0,    0,      -pi/3, 2*pi/3,    pi/3,  2*pi/3];
    [q,qd,qdd,qddd,time_max]=STrajectoryfunction(First_Theta,Final_Theta);
        q_new=q';
        qd_new=qd';
        qdd_new=qdd';
        qddd_new=qddd';
        i = 1:6;
        subplot(2,2,1);
        plot(0:0.001:time_max,q_new(:,i), 'LineWidth', 1.5)
        title('�ؽڽ�(��)')
        grid on
        subplot(2,2,2);
        plot(0:0.001:time_max,qd_new(:,i), 'LineWidth', 1.5)
        title('���ٶ�(��/s)')
        grid on
        hold on
        subplot(2,2,3);
        plot(0:0.001:time_max,qdd_new(:,i), 'LineWidth', 1.5)
        title('�Ǽ��ٶ�(��/s^2)')
        grid on
        hold on
        subplot(2,2,4);
        plot(0:0.001:time_max,qddd_new(:,i), 'LineWidth', 1.5)
        grid on
        hold on