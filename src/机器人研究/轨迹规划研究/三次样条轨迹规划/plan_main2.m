%% 自写cubicSpline_3函数测试
% 三次样条：周期三次样条，没有指定初始速度v0和终止速度vn，也就是v0和vn未知
q = [3, -2, -5, 0, 6, 12, 3];
t = [0, 5, 7, 8, 10, 15, 18];
t1 = [18, 23, 25, 26, 28, 33, 36];
n = length(t);
tt = 0.1;
[yy,dyy,ddyy] = cubicSpline_3(q, t, tt);
[yy_, dyy_, ddyy_] = cubicSpline_3(q, t1, tt);
subplot(3, 1, 1)
plot(t, q, 'o');
ylabel('位置')
grid on
hold on
plot([t(1):tt:t(n)], yy);
plot([t1(1):tt:t1(n)], yy_);
subplot(3, 1, 2)
% plot([t(1), t(n)], [v0, vn], 'o');
grid on
hold on
plot([t(1):tt:t(n)], dyy);
plot([t1(1):tt:t1(n)], dyy_);
ylabel('速度')
subplot(3, 1, 3)
grid on
hold on
plot([t(1):tt:t(n)], ddyy);
plot([t1(1):tt:t1(n)], ddyy_);
ylabel('加速度')
