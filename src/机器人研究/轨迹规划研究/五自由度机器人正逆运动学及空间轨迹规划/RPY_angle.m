%位姿矩阵求RPY，结果为弧度制
function [a,b,c]=RPY_angle(s)
a=atan2(s(2,1),s(1,1));
b=atan2(-s(3,1),(s(1,1)*cos(a)+s(2,1)*sin(a)));
c=atan2((-s(2,3)*cos(a)+s(1,3)*sin(a)),(s(2,2)*cos(a)-s(1,2)*sin(a)));
end

