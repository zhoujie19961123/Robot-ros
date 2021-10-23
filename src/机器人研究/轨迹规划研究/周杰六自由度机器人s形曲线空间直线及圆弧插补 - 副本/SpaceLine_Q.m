% 空间单一直线位置插补与单元四元数姿态插补 + 梯形加减速归一化处理/S型加减速曲线归一化处理
% 参数：起点S位置， 终点D位置
%      起点S的单元四元数Qs，终点的单元四元数Qd
%      起始速度v0，终止速度v1，最大速度vmax，最大加速度amax，最大加加速度jmax
%      插补周期t
% 返回值：插值点位置、单元四元数、插值点数
function [x,y,z,qk,N] = SpaceLine_Q(S, D, Qs, Qd, v0, v1, vmax, amax, jmax, t)
x1 = S(1); y1 = S(2); z1 = S(3);
x2 = D(1); y2 = D(2); z2 = D(3);

% 总位移S
s = sqrt(power(x2 - x1, 2) + power(y2 - y1, 2) + power(z2 - z1, 2));
%位置插值
[lambda, N] = Normalization_S(s, v0, v1, vmax, amax, jmax, t);
delta_x = x2 - x1;
delta_y = y2 - y1;
delta_z = z2 - z1;

% 计算两个四元数之间的夹角
dot_q = Qs(1)*Qd(1) + Qs(2)*Qd(2)+ Qs(3)*Qd(3) + Qs(4)*Qd(4);
if (dot_q < 0)
    dot_q = -dot_q;
end
%初始化得到的四元数
qk=zeros(N,4);
for i = 1: N
    % 位置插补
    x(i) = x1 + delta_x*lambda(i);
    y(i) = y1 + delta_y*lambda(i);
    z(i) = z1 + delta_z*lambda(i);
    % 单位四元数球面线性姿态插补
    % 插值点四元数
    if (dot_q > 0.9995)
        k0(i) = 1-lambda(i);
        k1(i) = lambda(i);
    else
        sin_t = sqrt(1 - power(dot_q, 2));
        omega = atan2(sin_t, dot_q);
        k0(i)= sin((1-lambda(i))*omega) / sin(omega);
        k1(i)= sin(lambda(i)*omega) / sin(omega);
    end
    qk(i,:)=Qs*k0(i)+Qd*k1(i);
    i=i+1;
end

end
