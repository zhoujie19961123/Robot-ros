%旋转矩阵转四元数
function  Q= RtoQuaternions(R)
t=sqrt(1+R(1,1)+R(2,2)+R(3,3))/2;
t1=(R(3,2)-R(2,3))/(4*t);
t2=(R(1,3)-R(3,1))/(4*t);
t3=(R(2,1)-R(1,2))/(4*t);

Q=[t,t1,t2,t3];
end
