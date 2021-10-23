%自己编写的六自由度机器人s曲线轨迹规划曲线
function [q,qd,qdd,qddd,time_max]=STrajectoryfunction(q00,q11)
%     First_Theta = [pi/2,-2*pi/3, -2*pi/3,   pi,    2*pi/3,   0];
%     Final_Theta = [pi,    0,      -pi/3,    pi,    pi/3,  2*pi/3];
%     q0=First_Theta*180/pi;
%     q1=Final_Theta*180/pi;
    q0=q00*180/pi;
    q1=q11*180/pi;
	v0 = 0;%返回一个与q0相同的矩阵，其所有元素为零
	v1 = 0;
    vmax =30;
    amax =20;
    jmax =10;
    %sigma = sign(q1 - q0);
    %sigma=zeros(6,6);
    % 得到规划参数Ta, Tv, Td, Tj1, Tj2, q0, q1, v0, v1, vlim, amax, amin, alima, alimd, jmax, jmin
    para=zeros(6,16);%初始化数组
    for num=1:6
      if(q0(num)~=q1(num))
          sigma(1,num)=sign(q1(num) - q0(num));
          para(num,:)= STrajectoryPara(q0(num), q1(num), v0, v1, vmax, amax, jmax); 
          i = 1; 
          T(num) = para(num,1) + para(num,2) + para(num,3);
          for t = 0: 0.001: T(num)
                   time(num,i) = 0.001*i;
                   q(num,i) = sigma(1,num)*S_position(t, para(num,1), para(num,2), para(num,3), para(num,4), para(num,5), para(num,6), para(num,7), para(num,8), para(num,9), para(num,10), para(num,11), para(num,12), para(num,13), para(num,14), para(num,15), para(num,16));
                   %q_new(num,i)=sigma(1,num)*q(num,i);
                   qd(num,i) = sigma(1,num)*S_velocity(t, para(num,1), para(num,2), para(num,3), para(num,4), para(num,5), para(num,6), para(num,7), para(num,8), para(num,9), para(num,10), para(num,11), para(num,12), para(num,13), para(num,14), para(num,15), para(num,16));
                   %qd_new(num,i)=sigma(num)*qd(num,i);
                   qdd(num,i) = sigma(1,num)*S_acceleration(t, para(num,1), para(num,2), para(num,3), para(num,4), para(num,5), para(num,6), para(num,7), para(num,8), para(num,9), para(num,10), para(num,11), para(num,12), para(num,13), para(num,14), para(num,15), para(num,16));
                   %qdd_new(num,i)= sigma(num)*qdd(num,i);
                   qddd(num,i) = sigma(1,num)*S_jerk(t, para(num,1), para(num,2), para(num,3), para(num,4), para(num,5), para(num,6), para(num,7), para(num,8), para(num,9), para(num,10), para(num,11), para(num,12), para(num,13), para(num,14), para(num,15), para(num,16));
                   %qddd_new(num,i)= sigma(num)*qddd(num,i);
               i = i + 1;
          end
      %%补偿先到达目标位置后角度恒为0
          time_max=max(T);
       if T(num)<time_max
              len11= fix(T(num)*1000)+1;
              len21= fix(time_max*1000)+1;
              long=len21-len11;
          for tt=1:long
              len_w=zeros(1,len11);
              len1=length(len_w);
              q(num,len1+tt)=q(num,len1);
            qd(num,len1+tt)=qd(num,len1);
            qdd(num,len1+tt)=qdd(num,len1);
            qddd(num,len1+tt)=qddd(num,len1);
          end
        end
      else
        %%输入角度相等时情况还需要判断
         zeros_time=fix(time_max*1000)+1;
           for yy=1:zeros_time
            %先初始化，再赋值
             q(num,yy)=q0(1,num);
             qd(num,1)=0;
             qdd(num,1)=0;
             qddd(num,1)=0;
             qd(num,yy)=qd(num,1);
             qdd(num,yy)=qdd(num,1);
             qddd(num,yy)=qddd(num,1);
           end
      end
    end

end

