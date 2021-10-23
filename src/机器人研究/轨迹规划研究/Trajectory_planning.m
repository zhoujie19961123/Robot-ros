%% 单关节多项式关节空间轨迹
%三阶多项式theta(t) = a0 + a1*t + a2*t^2 + a3*t^3
% 指定初始和终止点的位置theta_s theta_f，同时速度均为0
theta_s = 120; theta_f = 60; tf = 1;
a0_3 = theta_s;
a1_3 = 0;
a2_3 = (3/tf^2)*(theta_f - theta_s);
a3_3 = (-2/tf^3)*(theta_f - theta_s);
j = 1;
for t = 0: 0.02: 1
   theta_3(j) = a0_3 + a1_3*t + a2_3*t^2 + a3_3*t^3;
   theta_3d(j) = a1_3 + 2*a2_3*t + 3*a3_3*t^2;
   theta_3dd(j) = 2*a2_3 + 6*a3_3*t;
   theta_3ddd(j) = 6*a3_3;
   j = j + 1;
end
figure(1)
subplot(4, 1, 1)
plot([0:0.02:1], theta_3)
grid on
title('关节角(°)')
subplot(4, 1, 2)
plot([0:0.02:1], theta_3d)
grid on
title('角速度(°/s)')
subplot(4, 1, 3)
plot([0:0.02:1], theta_3dd)
grid on
title('角加速度(°/s^2)')
subplot(4, 1, 4)
plot([0:0.02:1], theta_3ddd)
grid on
title('角加速度变化率')
hold on

%% 五阶多项式theta(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5
% 指定初始和终止点的位置，另外角速度和角加速度均为0
%起始角度120；终止角度60
theta_s = 120; theta_f = 60; tf = 1;
theta_fd = 0; theta_fdd = 0; theta_sd = 0; theta_sdd = 0;
a0_5 = theta_s; a1_5 = theta_sd; a2_5 = theta_sdd / 2;
a3_5 = (20*theta_f - 20*theta_s - (8*theta_fd + 12*theta_sd)*tf - (3*theta_sdd - theta_fdd)*tf^2) / (2*tf^3);
a4_5 = (30*theta_s - 30*theta_f + (14*theta_fd + 16*theta_sd)*tf + (3*theta_sdd - 2*theta_fdd)*tf^2) / (2*tf^4);
a5_5 = (12*theta_f - 12*theta_s - (6*theta_fd + 6*theta_sd)*tf - (theta_sdd - theta_fdd)*tf^2) / (2*tf^5);
k = 1;
for t = 0: 0.02: 1
   theta_5(k) = a0_5 + a1_5*t + a2_5*t^2 + a3_5*t^3 + a4_5*t^4 + a5_5*t^5;
   theta_5d(k) = a1_5 + 2*a2_5*t + 3*a3_5*t^2 + 4*a4_5*t^3 + 5*a5_5*t^4;
   theta_5dd(k) = 2*a2_5 + 6*a3_5*t + 12*a4_5*t^2 + 20*a5_5*t^3;
   theta_5ddd(k) = 6*a3_5 + 24*a4_5*t + 60*a5_5*t^2;
   k = k + 1;
end
figure(2)
subplot(4, 1, 1)
plot([0:0.02:1], theta_5)
grid on
title('关节角(°)')
subplot(4, 1, 2)
plot([0:0.02:1], theta_5d)
grid on
title('角速度(°/s)')
subplot(4, 1, 3)
plot([0:0.02:1], theta_5dd)
grid on
title('角加速度(°/s^2)')
subplot(4, 1, 4)
plot([0:0.02:1], theta_5ddd)
grid on
title('角加速度变化率')

%% 两段带有中间点路径的三次曲线此时用户给定初始时刻和终止时刻的
%位置、速度和加速度，给定了中间点的位置，但是没有指定中间时刻的速度，
%因此在两条三次曲线的连接处，用速度和加速度均连续作为新的约束条件
%两段带有中间点的三项多项式(约束条件为连接点的速度和加速度相等)
% theta(t)_1 = a10 + a11*t1 + a12*t1^2 + a13*t1^3
% theta(t)_2 = a20 + a21*t2 + a22*t2^2 + a23*t2^3
theta_s_ = 60; theta_v_ = 120; theta_f_ = 30;
t = 1; tf = 2;
theta_s_d_ = 0; theta_s_dd_ = 0; 
theta_f_d_ = 0; theta_f_dd_ = 0;
a10 = theta_s_; 
a11 = 0;
a12 = (12*theta_v_ - 3*theta_f_ - 9*theta_s_) / (4*t^2);
a13 = (-8*theta_v_ + 3*theta_f_ + 5*theta_s_) / (4*t^3);
a20 = theta_v_; 
a21 = (3*theta_f_ - 3*theta_s_) / (4*t);
a22 = (-12*theta_v_ + 6*theta_f_ + 6*theta_s_) / (4*t^2);
a23 = (8*theta_v_ - 5*theta_f_ - 3*theta_s_) / (4*t^3);
s = 1;
for T = 0: 0.02: 1
    theta_1(s) = a10 + a11*T + a12*T^2 + a13*T^3;
    theta_d_1(s) = a11 + 2*a12*T + 3*a13*T^2;
    theta_dd_1(s) = 2*a12 + 6*a13*T;
    theta_ddd_1(s) = 6*a13;
    s = s + 1;
end
s = 1;
for T = 0: 0.02: 1
    theta_2(s) = a20 + a21*T + a22*T^2 + a23*T^3;
    theta_d_2(s) = a21 + 2*a22*T + 3*a23*T^2;
    theta_dd_2(s) = 2*a22 + 6*a23*T;
    theta_ddd_2(s) = 6*a23;
    s = s + 1;
end
% 去掉首尾
theta_ = [theta_1, theta_2(2: 51)];
theta_d_ = [theta_d_1, theta_d_2(2: 51)];
theta_dd_ = [theta_dd_1, theta_dd_2(2: 51)];
theta_ddd_ = [theta_ddd_1, theta_ddd_2(2: 51)];
figure(3)
subplot(4, 1, 1)
plot([0:0.02:2], theta_)
grid on
title('关节角(°)')
subplot(4, 1, 2)
plot([0:0.02:2], theta_d_*pi/180)
grid on
title('角速度(°/s)')
subplot(4, 1, 3)
plot([0:0.02:2], theta_dd_*pi/180)
grid on
title('角加速度(°/s^2)')
subplot(4, 1, 4)
plot([0:0.02:2], theta_ddd_*pi/180)
grid on
title('角加速度变化率')

%% 多段带有中间点的三次多项式
% 用户指定初始点、终止点、多个中间点的时刻以及各点对应的位置、速度
%多段带有中间点的三次多项式
% 指定各点的时间及其对应的位置、速度
% t0 = 0, t1 = 2, t2 = 4, t3 = 8, t4 = 10
% p0 = 10, p1 = 20, p2 = 0, p3 = 30, p4 = 40
% v0 = 0, v1 = -10, v2 = 10, v3 = 3, v4 = 0
t = [0,   2,  4,  8, 10];
p = [10, 20,  0, 30, 40];
v = [0, -10, 10,  3,  0];
% 初始化
T = t(1); P = p(1); V = v(1);
for i = 1:4
    % 四个三阶多项式的各项参数
    a0(i) = p(i);
    a1(i) = v(i);
    Tf = t(i+1) - t(i);
    a2(i) = (3/Tf^2)*(p(i+1) - p(i)) - (2/Tf)*v(i) - (1/Tf)*v(i+1);
    a3(i) = (-2/Tf^3)*(p(i+1) - p(i)) + (1/Tf^2)*(v(i+1) + v(i));
    % 时间均分100份,并累加时间横坐标
    %linspace是Matlab中的一个指令，用于产生x1,x2之间的N点行矢量。其中x1、x2、N分别为起始值、中止值、元素个数
    N = linspace(t(i), t(i+1), 100);
    T = [T, N(2: 100)];% 累加时间坐标
    % 计算各多项式
    pk = a0(i) + a1(i)*(N - N(1)) + a2(i)*power(N - N(1), 2) + a3(i)*power(N - N(1), 3);
    vk = a1(i) + 2*a2(i)*(N - N(1)) + 3*a3(i)*power(N - N(1), 2);
    qk = 2*a2(i) + 6*a3(i)*(N - N(1));
    %去首尾
    P = [P, pk(2: 100)];
    V = [V, vk(2: 100)];
    if (i == 1)
        Q = 2*a2(i);
    end
    Q = [Q, qk(2: 100)];
end
figure(4)
subplot(3, 1, 1);
plot(T, P, 'r')
grid on
hold on
plot(t, p, 'or')
title('关节角(°)')
subplot(3, 1, 2)
plot(T, V, 'b')
grid on
hold on
plot(t, v, 'ob')
title('角速度(°/s)')
subplot(3, 1, 3)
plot(T, Q, 'g')
grid on
title('角加速度(°/s^2)')

%% 多段带中间点的五次多项式，同时中间速度平滑处理（和三次多项式进行比较）
% 用户指定初始点、终止点、多个中间点的时刻以及各点对应的位置、速度
% 指定各点的时间及其对应的位置、速度。使用五次多项式，还需要指定各点的加速度：
% 该方法由于对中间点的速度进行平滑处理，因此中间点速度不一定是期望速度，适用于对中间点速度无要求的情况
% 指定各点的时间及其对应的位置、速度
% t0 = 0, t1 = 2, t2 = 4, t3 = 8, t4 = 10
% p0 = 10, p1 = 20, p2 = 0, p3 = 30, p4 = 40
% v0 = 0, v1 = -10, v2 = 10, v3 = 3, v4 = 0
% 初始、中间点及终止点的加速度均为0
t = [0, 2, 4, 8, 10];
p = [10, 20, 0, 30, 40];
v = [0, -10, 10, 3, 0];
a = [0, 0, 0, 0, 0];
% 初始化
T = t(1); P_ = p(1); V_ = v(1); A_ = a(1);
% 处理中间速度
for k = 1: 4
    if (k == 1)
        v2(k) = v(k);
    else
        dk1 = (p(k) - p(k-1)) / (t(k) - t(k-1));
        dk2 = (p(k+1) - p(k)) / (t(k+1) - t(k));
        if (dk1 >= 0 && dk2 >= 0 || dk1 <= 0 && dk2 <= 0)
            v2(k) = (1/2)*(dk1 + dk2);
        else
            v2(k) = 0;
        end
    end
end
v2(5) = v(5);
for i = 1: 4
    % 计算四个五次多项式的各项系数
    tf = t(i+1) - t(i);
    a0(i) = p(i); 
    a1(i) = v2(i); 
    a2(i) = a(i) / 2;
    a3(i) = (20*p(i+1) - 20*p(i) - (8*v2(i+1) + 12*v2(i))*tf - (3*a(i) - a(i+1))*tf^2) / (2*tf^3);
    a4(i) = (30*p(i) - 30*p(i+1) + (14*v2(i+1) + 16*v2(i))*tf + (3*a(i) - 2*a(i+1))*tf^2) / (2*tf^4);
    a5(i) = (12*p(i+1) - 12*p(i) - (6*v2(i+1) + 6*v2(i))*tf - (a(i) - a(i+1))*tf^2) / (2*tf^5);
    % 时间均分100份,并累加时间横坐标
    N = linspace(t(i), t(i+1), 100);
    T = [T, N(2: 100)]; % 累加时间坐标
    % 计算各多项式theta(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5
    % position
    pk = a0(i) + a1(i)*(N - N(1)) + a2(i)*power(N - N(1), 2) + a3(i)*power(N - N(1), 3) + a4(i)*power(N - N(1), 4) + a5(i)*power(N - N(1), 5);
    % velocity
    vk = a1(i) + 2*a2(i)*(N - N(1)) + 3*a3(i)*power(N - N(1), 2) + 4*a4(i)*power(N - N(1), 3) + 5*a5(i)*power(N - N(1), 4);
    % acceleration
    ak = 2*a2(i) + 6*a3(i)*(N - N(1)) + 12*a4(i)*power(N - N(1), 2) + 20*a5(i)*power(N - N(1), 3);
    P_ = [P_, pk(2: 100)];
    V_ = [V_, vk(2: 100)];
    A_ = [A_, ak(2: 100)];
end
figure(5)
subplot(3, 1, 1);
plot(T, P_, 'r')
grid on
hold on
plot(t, p, 'or')
title('关节角(°)')
subplot(3, 1, 2)
plot(T, V_, 'b')
grid on
hold on
plot(t, v2, 'ob')
title('角速度(°/s)')
subplot(3, 1, 3)
plot(T, A_, 'g')
hold on
plot(t, a, 'g--')
grid on
title('角加速度(°/s^2)')

%% 拐点对称的抛物线轨迹
% 已知起始和结束时刻的位置和速度
t0 = 0; t = 8; T = t - t0;
tf = T / 2; % 拐点
v0 = 0; v1 = 0;
theta_s = 0; theta = 10; theta_f = (theta_s + theta) / 2;
h = theta - theta_s;
% theta_a(t) = a10 + a11*(t - t0) + a12*(t - t0)^2 加速段
a10 = theta_s; a11 = v0; a12 = (2/T^2)*(h - v0*T);
% matlab中这样计算是很方便的，但是c里面无法直接合并向量，得借助循环遍历
Ta = linspace(t0, tf, 400);
theta_a = a10 + a11*(Ta - t0) + a12*power(Ta - t0, 2);
theta_ad = a11 + 2*a12*(Ta - t0);
theta_add = 2*a12;
% theta_b(t) = a20 + a21*(t - tf) + a22*(t - tf)^2 减速段
Tb = linspace(tf, t, 400);
Tn = [Ta, Tb(2: 400)];
a20 = theta_f; a21 = 2*(h/T) - v1; a22 = (2/T^2)*(v1*T - h); 
theta_b = a20 + a21*(Tb - tf) + a22*power(Tb - tf, 2);
theta_bd = a21 + 2*a22*(Tb - tf);
theta_bdd = 2*a22;
theta = [theta_a, theta_b(2: 400)];
theta_d = [theta_ad, theta_bd(2: 400)];
figure(1)
subplot(3, 1, 1)
plot(Tn, theta, 'r')
ylabel('position')
hold on
plot(tf, theta_f, 'or')
grid on
subplot(3, 1, 2)
plot(Tn, theta_d, 'b')
ylabel('velocity')
hold on
plot(tf, theta_d(400), 'ob')
grid on
for i = 1: 799
    theta_dd(i) = theta_add;
    if (i > 400)
        theta_dd(i) = theta_bdd;
    end
end
subplot(3, 1, 3)
plot(Tn, theta_dd, 'g')
ylabel('acceleration')
hold on
plot(tf, theta_dd(400), 'og')
grid on

%% 一般的情况，拐点两边不对称，但是加速度对称恒定
% 已知起始和结束时刻的位置和速度，同时拐点的位置和速度具有连续性
t0 = 0; t1 = 8; T = t1 - t0; tf = 4;
ta = tf - t0; tb = t1 - tf;
v0 = 0.1; v1 = -1; 
q0 = 0; q1 = 10; h = q1 - q0;
% theta_a(t) = a10 + a11*(t - t0) + a12*(t - t0)^2 加速段
a10 = q0; a11 = v0; a12 = (2*h - v0*(T + ta) - v1*tb) / (2*T*tb);
Ta = linspace(t0, tf, (ta/T)*800);
q_a = a10 + a11*(Ta - t0) + a12*power(Ta - t0, 2);
q_ad = a11 + 2*a12*(Ta- t0);
q_add = 2*a12;
% theta_b(t) = a20 + a21*(t - tf) + a22*(t - tf)^2 减速段
a20 = (2*q1*ta + tb*(2*q0 + ta*(v0 - v1))) / (2*T);
a21 = (2*h - v0*ta - v1*tb) / T;
a22 = -(2*h - v0*ta - v1*(T + tb)) / (2*T*tb);
Tb = linspace(tf, t1, (tb/T)*800);
q_b = a20 + a21*(Tb - tf) + a22*power(Tb - tf, 2);
q_bd = a21 + 2*a22*(Tb - tf);
q_bdd = 2*a22;
Tn = [Ta, Tb(2: (tb/T)*800)];
q = [q_a, q_b(2: (tb/T)*800)];
q_d = [q_ad, q_bd(2: (tb/T)*800)];
for i = 1:799
   q_dd(i) = q_add;
   if (i > (ta/T)*800)
       q_dd(i) = q_bdd;
   end
end
figure(2)
subplot(3, 1, 1)
plot(Tn, q, 'r');
hold on
plot(tf, q_a((ta/T)*800), 'or')
grid on
ylabel('position')
subplot(3, 1, 2)
plot(Tn, q_d, 'b')
hold on
plot(tf, q_ad((ta/T)*800), 'ob')
grid on
subplot(3, 1, 3)
plot(Tn, q_dd, 'g')
grid on

%% 梯形加减速(都存在没有最大速度和最大加速度限制的问题，
% 当机械系统存在速度和加速度限制范围时，上述方法就不太适合。梯形加减速，可限制最大速度和最大加速度
% 下面的梯形加减速和S型曲线就不会存在这种问题)
%与抛物线拟合的线性函数（线性轨迹）
% 用户给定起始速度、终止速度、加速度、减速度、最大速度及位移参数
% 该算法需要计算出加速段、匀速段以及减速段对应的时间Ta Tv Td
% t0 = 0, p0 = 5, p1 = 30, v0 = 50, vmax = 150, v1 = 20, aa = 1000
% ad = -1500
t0 = 2;
p0 = 5; p1 = 30;
v0 = 50; vmax = 150; v1 = 20;
aa = 1000; ad = -1500;%第一段加速度及减速段加速度
h = p1 - p0;
% 可达到的最大速度
vf = sqrt((2.0*aa*ad*h - aa*v1^2 + ad*v0^2) / (ad - aa));
% 当vf<vmax时，说明系统能够达到的最大速度无法满足用户要求，此时匀速段的最大速度为vv = vf；
% 当vf>vmax时，说明给定的参数可以达到用户限定的最大速度，但是又不能超过限定的最大速度，因此匀速段的最大速度为vv = vmax。
% 确定匀速阶段速度
if (vf < vmax)
    vv = vf;
else
    vv = vmax;
end
% 计算加速阶段的时间和位移
Ta = (vv - v0) / aa;
La = v0*Ta + (1.0/2.0)*aa*Ta^2;
% 计算匀速阶段的时间和位移
Tv = (h - (vv^2 - v0^2)/(2.0*aa) - (v1^2 - vv^2)/(2.0*ad)) / vv;
Lv = vv*Tv;
% 计算减速阶段的时间和位移
Td = (v1 - vv) / ad;
Ld = vv*Td + (1.0/2.0)*ad*Td^2;

k = 1;
ts = 0.001;
% 计算轨迹的离散点
for t = t0: ts: (t0+Ta+Tv+Td)
    time(k) = t;
    t = t - t0;
    if (t >= 0 && t < Ta)
        p(k) = p0 + v0*t + (1.0/2.0)*aa*t^2;
        pd(k) = v0 + aa*t;
        pdd(k) = aa;
    elseif (t >= Ta && t < Ta+Tv)
        p(k) = p0 + La + vv*(t - Ta);
        pd(k) = vv;
        pdd(k) = 0;
    elseif (t >= Ta+Tv && t <= Ta+Tv+Td)
        p(k) = p0 + La + Lv + vv*(t - Ta - Tv) + (1.0/2.0)*ad*power(t - Ta - Tv, 2);
        pd(k) = vv + ad*(t - Ta - Tv);
        pdd(k) = ad;
    end
    k = k + 1;
end
figure(1)
subplot(3, 1, 1)
plot(time, p, 'r', 'LineWidth', 1.5)
ylabel('position')
grid on
subplot(3, 1, 2)
plot(time, pd, 'b', 'LineWidth', 1.5)
ylabel('velocity')
grid on
subplot(3, 1, 3)
plot(time, pdd, 'g', 'LineWidth', 1.5)
ylabel('acceleration')
grid on
%由结果可以看出，梯形曲线在t0、Ta、Ta+Tv以及Ta+Tv+Td时刻时加速度不连续，速度过渡不平滑，
%存在冲击，这是梯形曲线的缺点，因此该加减速曲线常用于低速、低成本的运动控制过程。下面的S型曲线能解决这个问题。






