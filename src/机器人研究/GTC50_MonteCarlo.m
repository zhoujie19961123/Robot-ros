%GTC50机器人机械臂工作域-蒙特卡洛法则
for i=1:100000
    a1=0.75;
    a2=1;
    a3=2.65;
    a4=1.39;
    a5=0.1975;
    d1=1.195;
    d6=0.1455;
    d7=0.228;
    d8=-0.0303;
    d9=0.9921;
    %theta=min+角度范围*rand
    theta1=-pi+2*pi*rand;
    %theta1=0;
    theta2=1.1343+0.9442*rand;
    theta3=-2.0670+0.8862*rand;
    theta4=-1.5641+1.5533*rand;
    theta5=-0.3937+1.5621*rand;
    theta6=1.2217+0.6981*rand;
    %theta6=pi/2;
    theta7=-pi+2*pi*rand;
   %x(i)=(cos(theta1)*(695*cos(theta2 + theta3 + theta4) + 711*cos(theta2 + theta3 + theta4 + theta5) + 1325*cos(theta2 + theta3) + 500*cos(theta2) + 375))/500
   %y(i)=(sin(theta1)*(695*cos(theta2 + theta3 + theta4) + 711*cos(theta2 + theta3 + theta4 + theta5) + 1325*cos(theta2 + theta3) + 500*cos(theta2) + 375))/500
  % z(i)=239/200 - (711*sin(theta2 + theta3 + theta4 + theta5))/500 - (53*sin(theta2 + theta3))/20 - sin(theta2) - (139*sin(theta2 + theta3 + theta4))/100
   x(i)=a1*cos(theta1) - d6*sin(theta2 + theta3 + theta4 + theta5)*cos(theta1) + a2*cos(theta1)*cos(theta2) + d7*cos(theta6)*sin(theta1) + d9*cos(theta6)*sin(theta1) + d7*cos(theta2 + theta3 + theta4 + theta5)*cos(theta1)*sin(theta6) - d8*sin(theta2 + theta3 + theta4 + theta5)*cos(theta1)*cos(theta7) + d9*cos(theta2 + theta3 + theta4 + theta5)*cos(theta1)*sin(theta6) + a4*cos(theta2 + theta3)*cos(theta1)*cos(theta4) - a4*sin(theta2 + theta3)*cos(theta1)*sin(theta4) + a3*cos(theta1)*cos(theta2)*cos(theta3) - a3*cos(theta1)*sin(theta2)*sin(theta3) + d8*sin(theta1)*sin(theta6)*sin(theta7) + a5*cos(theta2 + theta3 + theta4)*cos(theta1)*cos(theta5) - a5*sin(theta2 + theta3 + theta4)*cos(theta1)*sin(theta5) - d8*cos(theta2 + theta3 + theta4 + theta5)*cos(theta1)*cos(theta6)*sin(theta7);
   y(i)=a1*sin(theta1) - d6*sin(theta2 + theta3 + theta4 + theta5)*sin(theta1) - d7*cos(theta1)*cos(theta6) - d9*cos(theta1)*cos(theta6) + a2*cos(theta2)*sin(theta1) + d7*cos(theta2 + theta3 + theta4 + theta5)*sin(theta1)*sin(theta6) - d8*sin(theta2 + theta3 + theta4 + theta5)*cos(theta7)*sin(theta1) + d9*cos(theta2 + theta3 + theta4 + theta5)*sin(theta1)*sin(theta6) + a4*cos(theta2 + theta3)*cos(theta4)*sin(theta1) - a4*sin(theta2 + theta3)*sin(theta1)*sin(theta4) + a3*cos(theta2)*cos(theta3)*sin(theta1) - d8*cos(theta1)*sin(theta6)*sin(theta7) - a3*sin(theta1)*sin(theta2)*sin(theta3) + a5*cos(theta2 + theta3 + theta4)*cos(theta5)*sin(theta1) - a5*sin(theta2 + theta3 + theta4)*sin(theta1)*sin(theta5) - d8*cos(theta2 + theta3 + theta4 + theta5)*cos(theta6)*sin(theta1)*sin(theta7);
   z(i)=d1 + (d7*cos(theta2 + theta3 + theta4 + theta5 - theta6))/2 + (d8*cos(theta2 + theta3 + theta4 + theta5 - theta7))/2 + (d9*cos(theta2 + theta3 + theta4 + theta5 - theta6))/2 + (d8*cos(theta2 + theta3 + theta4 + theta5 + theta6 + theta7))/4 + d6*cos(theta2 + theta3 + theta4 + theta5) + a5*sin(theta2 + theta3 + theta4 + theta5) + a3*sin(theta2 + theta3) - (d8*cos(theta2 + theta3 + theta4 + theta5 + theta6 - theta7))/4 + (d8*cos(theta2 + theta3 + theta4 + theta5 - theta6 + theta7))/4 + a2*sin(theta2) - (d7*cos(theta2 + theta3 + theta4 + theta5 + theta6))/2 + (d8*cos(theta2 + theta3 + theta4 + theta5 + theta7))/2 - (d9*cos(theta2 + theta3 + theta4 + theta5 + theta6))/2 + a4*sin(theta2 + theta3 + theta4) - (d8*cos(theta2 + theta3 + theta4 + theta5 - theta6 - theta7))/4;
end
plot3(x,y,z,'b.','MarkerSize',0.5)