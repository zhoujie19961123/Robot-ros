%% S曲线规划
% 边界条件
clc
clear
q0 = 0; q1 = 120; 
v0 = 0; v1 = 0;
vmax = 30; amax = 20; jmax = 10;
sigma = sign(q1 - q0);
% 得到规划参数Ta, Tv, Td, Tj1, Tj2, q0, q1, v0, v1, vlim, amax, amin, alima, alimd, jmax, jmin
para = STrajectoryPara(q0, q1, v0, v1, vmax, amax, jmax)
i = 1; 
T = para(1) + para(2) + para(3)
for t = 0: 0.001: T
   time(i) = 0.001*i;
   q(i) = S_position(t, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   qd(i) = S_velocity(t, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   qdd(i) = S_acceleration(t, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   qddd(i) = S_jerk(t, para(1), para(2), para(3), para(4), para(5), para(6), para(7), para(8), para(9), para(10), para(11), para(12), para(13), para(14), para(15), para(16));
   i = i + 1;
end
q = sigma*q;
qd = sigma*qd;
qdd = sigma*qdd;
qddd = sigma*qddd;
figure(2)
subplot(4, 1, 1)
plot(time, q, 'r', 'LineWidth', 1.5)
grid on
title('关节角(°)')
subplot(4, 1, 2)
plot(time, qd, 'b', 'LineWidth', 1.5)
grid on
title('角速度(°/s)')
subplot(4, 1, 3)
plot(time, qdd, 'g', 'LineWidth', 1.5)
grid on
title('角加速度(°/s^2)')
subplot(4, 1, 4)
plot(time, qddd, 'LineWidth', 1.5)
grid on
title('角加速度变化率')

