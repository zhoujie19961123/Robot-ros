%% ��дcubicSpline_2��������
%δָ���м��ٶ�
q = [3, -2, -5, 0, 6, 12, 8];
t = [0, 5, 7, 8, 10, 15, 18];
n = length(t);
v0 = 2; vn = -3; tt = 0.1;
[yy,dyy,ddyy] = cubicSpline_2(q, t, v0, vn, tt);
subplot(3, 1, 1)
plot(t, q, 'o');
ylabel('λ��')
grid on
hold on
plot([t(1):tt:t(n)], yy);
subplot(3, 1, 2)
plot([t(1), t(n)], [v0, vn], 'o');
grid on
hold on
plot([t(1):tt:t(n)], dyy);
ylabel('�ٶ�')
subplot(3, 1, 3)
grid on
hold on
plot([t(1):tt:t(n)], ddyy);
ylabel('���ٶ�')
