%% ��дcubicSpline_4��������
q = [3, -2, -5, 0, 6, 12, 8];
t = [0, 5, 7, 8, 10, 15, 18];
v0 = 2; vn = -3; a0 = 0; an = 0;
tt = 0.1;
n = length(t);
[yy,dyy,ddyy,q1,qn_1] = cubicSpline_4(q, t, v0, vn, a0, an, tt);
% �������������q1_��qn-1_�����������Ӧ��ʱ���
t1_ = (t(1)+t(2)) / 2;
tn_1_ = (t(n-1)+t(n)) / 2;
% ����ʱ������
t = [t(1), t1_, t(2: n-1), tn_1_, t(n)];
n = length(t);% ����n 
% ����q
q = [q(1), q1, q(2: n-3), qn_1, q(n-2)];
subplot(3, 1, 1)
plot(t, q, 'o');
ylabel('λ��')
grid on
hold on
plot([t(1):tt:t(n)], yy);
hold on
plot(t(2), q(2), 'r*');
plot(t(n-1), q(n-1), 'r*');
subplot(3, 1, 2)
% plot([t(1), t(n)], [v0, vn], 'o');
grid on
hold on
plot([t(1):tt:t(n)], dyy);
ylabel('�ٶ�')
subplot(3, 1, 3)
grid on
hold on
plot([t(1):tt:t(n)], ddyy);
ylabel('���ٶ�')
