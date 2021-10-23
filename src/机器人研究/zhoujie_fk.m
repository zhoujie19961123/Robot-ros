syms a1 a2 a3 a4 a5 d1 d6 d7 d8 d9 theta1 theta2 theta3 theta4 theta5 theta6 theta7
%考虑末端抓具相对于7轴的位置姿态TT矩阵
% 标准的T为
% T=[cos(theta) -cos(a)*sin(theta)  sin(a)*sin(theta)    ai*cos(theta);
%    sin(theta) cos(a)*cos(theta)   -sin(a)*cos(theta)   ai*sin(theta);
%     0           sin(a)             cos(a)               di;
%     0           0                   0                   1];
T1=[cos(theta1) 0  sin(theta1)   a1*cos(theta1);
    sin(theta1) 0  -cos(theta1)  a1*sin(theta1);
    0           1   0           d1;
    0           0   0           1];

T2=[cos(theta2) -sin(theta2)  0  a2*cos(theta2);
    sin(theta2) cos(theta2)   0  a2*sin(theta2);
    0           0             1         0;
    0           0             0         1];

T3=[cos(theta3) -sin(theta3)  0  a3*cos(theta3);
    sin(theta3) cos(theta3)   0  a3*sin(theta3);
    0           0             1         0;
    0           0             0         1];

T4=[cos(theta4) -sin(theta4)       0     a4*cos(theta4);
    sin(theta4)  cos(theta4)       0     a4*sin(theta4);
    0            0                1         0;
    0            0                0         1];

T5=[cos(theta5)  0     -sin(theta5)     a5*cos(theta5);
    sin(theta5)   0     cos(theta5)     a5*sin(theta5);
    0            -1            0         0;
    0            0             0         1];

T6=[cos(theta6) 0    sin(theta6)        0;
    sin(theta6) 0    -cos(theta6)        0;
    0           1           0         d6;
    0           0           0         1];
T7=[cos(theta7)  -sin(theta7)     0      0;
    sin(theta7)  cos(theta7)      0      0;
    0            0                1      d7;
    0            0                0      1];
%TT为末端抓具相对T7的
TT=[1            0       0      0;
    0            1       0      d8;
    0            1       1      d9;
    0            0       0      1]
T=T1*T2*T3*T4*T5*T6*T7*TT;
simplify(T)
