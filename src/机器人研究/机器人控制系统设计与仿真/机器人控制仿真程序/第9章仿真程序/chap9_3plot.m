close all;
figure(1);
plot(t,y(:,1),'r',t,y(:,2),'b');
xlabel('time(s)');ylabel('Position tracking');