%theta1=want(1,1);
% theta2=want(1,2);
% theta3=want(1,3);
% theta4=want(1,4);
% theta5=want(1,5);
% theta6=want(1,6);
%标准的DH
% T=[cos(theta) -cos(a)*sin(theta)  sin(a)*sin(theta)    ai*cos(theta);
%    sin(theta) cos(a)*cos(theta)   -sin(a)*cos(theta)   ai*sin(theta);
%     0           sin(a)             cos(a)               di;
%     0           0                   0                   1];
%GTC50  标准的DH建立的可以使用
%抓具末端相对于末端坐标系的位置为[0,-0.0303,0.9921]
%             theta     d        a        alpha       offset 
%     L1 = Link([0        1.195    0.75   pi/2],     'standard');
%     L2 = Link([0         0       1          0],    'standard');
%     L3 = Link([0         0      2.65        0],    'standard');
%     L4 = Link([0         0      1.39        0],    'standard');
%     L5 = Link([0         0      0.1975     -pi/2], 'standard'); 
%     L6 = Link([0      0.1455     0          pi/2],  'standard');
%     L7 = Link([0      0.228      0          0],     'standard');
%六自由度机器人正运动学
syms theta1 theta2 theta3 theta4 theta5 theta6 d1 d4 d5 d6 a2 a3 nx ny nz ox oy oz ax ay az px py pz
T1=[cos(theta1) 0   sin(theta1)    0;
    sin(theta1) 0   -cos(theta1)   0;
    0           1         0        d1;
    0           0         0        1];

T2=[cos(theta2) -sin(theta2)  0    a2*cos(theta2);
   sin(theta2)  cos(theta2)   0    a2*sin(theta2);
    0           0             1          0;
    0           0             0          1];

T3=[cos(theta3) -sin(theta3)  0   a3*cos(theta3);
    sin(theta3) cos(theta3)   0   a3*sin(theta3);
    0           0             1           0;
    0           0             0           1];

T4=[cos(theta4) 0     sin(theta4)     0;
    sin(theta4) 0    -cos(theta4)    0;
    0           1             0      d4;
    0           0             0      1];

T5=[cos(theta5) 0   -sin(theta5)    0;
   sin(theta5)  0    cos(theta5)    0;
    0           -1          0       d5;
    0           0           0       1];

T6=[cos(theta6)  -sin(theta6)   0   0;
    sin(theta6)   cos(theta6)   0   0;
    0             0             1   d6;
    0             0             0   1];

T06=[nx   ox   ax   px;
     ny   oy   ay   py;
     nz   oz   az   pz;
     0    0     0   1];

 TT1=inv(T1)*T06;
 simplify(TT1)
 TT2=T2*T3*T4*T5*T6;
 simplify(TT2)
 
%逆解程序
%             theta1=atan2(d4,sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
%             theta5=atan2(sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
%             theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
%             theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
%             A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
%             B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
%             nn=sqrt(A^2+B^2);
%             xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
%             yy1=sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
%             %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
%             %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
%             theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
%             xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
%             yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
%             theta23=atan2(xx6/a3,yy6/a3);
%             %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
%             theta3=theta23-theta2;
%             theta4=theta234-theta23;
T=T1*T2*T3*T4*T5*T6;
simplify(T)



