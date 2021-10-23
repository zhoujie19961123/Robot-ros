close all;

figure(1);
subplot(211);
plot(t,y1(:,1),'r',t,y1(:,2),'b');
xlabel('time(s)');ylabel('Position tracking of joint 1');
subplot(212);
plot(t,y2(:,1),'r',t,y2(:,2),'b');
xlabel('time(s)');ylabel('Position tracking of joint 2');

figure(2);
subplot(211);
plot(t,y1(:,1)-y1(:,2),'r');
xlabel('time(s)');ylabel('Position tracking error of joint 1');
subplot(212);
plot(t,y2(:,1)-y2(:,2),'r');
xlabel('time(s)');ylabel('Position tracking error of joint 2');

figure(3);
subplot(211);
plot(t,P(:,1),'r');
xlabel('time(s)');ylabel('Control input 1');
subplot(212);
plot(t,P(:,2),'r');
xlabel('time(s)');ylabel('Control input 2');

figure(4);
subplot(211);
plot(t,P(:,3),'r');
xlabel('time(s)');ylabel('K 1');
subplot(212);
plot(t,P(:,4),'r');
xlabel('time(s)');ylabel('K 2');