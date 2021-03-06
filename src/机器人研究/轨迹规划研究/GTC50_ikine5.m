%使用函数aa=GTC50_ikine5(1,tt)
%传入目标矩阵
function p = GTC50_ikine5(choise,tt)
nx=tt(1,1); 
ny=tt(2,1);
nz=tt(3,1);
ox=tt(1,2);
oy=tt(2,2);
oz=tt(3,2);
ax=tt(1,3);
ay=tt(2,3);
az=tt(3,3);
px=tt(1,4);
py=tt(2,4);
pz=tt(3,4);
d1=0.1065;
d4=0.1109;
d5=0.1109;
d6=0.08409;
a2=-0.408;
a3=-0.382;
% p=[ nx   ox   ax   px;
%     ny   oy   ay   py;
%     nz   oz   az   pz;
%     0    0     0   1]
%逆解共有8组结果,通过switch语句选择输出哪个解
switch choise
    case 1
%逆解结果1
            theta1=atan2(d4,sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
            
    case 2
%逆解结果2
            theta1=atan2(d4,sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=-sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
    case 3
        %逆解结果3
            theta1=atan2(d4,sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(-sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
    case 4
            theta1=atan2(d4,sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(-sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=-sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
    case 5
            theta1=atan2(d4,-sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
    case 6
            theta1=atan2(d4,-sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=-sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
    case 7
            theta1=atan2(d4,-sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(-sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
    case 8
            theta1=atan2(d4,-sqrt((d6*ay-py)^2+(px-d6*ax)^2-d4^2))-atan2(d6*ay-py,px-d6*ax);
            theta5=atan2(-sqrt((nx*sin(theta1)-ny*cos(theta1))^2+(ox*sin(theta1)-oy*cos(theta1))^2),ax*sin(theta1)-ay*cos(theta1));
            theta6=atan2(-(ox*sin(theta1)-oy*cos(theta1))/sin(theta5),(nx*sin(theta1)-ny*cos(theta1))/sin(theta5));
            theta234=atan2(-(az/sin(theta5)),-(ax*cos(theta1)+ay*sin(theta1))/sin(theta5));
            A=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)+d6*sin(theta5)*cos(theta234);
            B=pz-d1+d5*cos(theta234)+d6*sin(theta5)*sin(theta234);
            nn=sqrt(A^2+B^2);
            xx1=(A^2+B^2+a2^2-a3^2)/(2*a2*nn);
            yy1=-sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2);
            %theta2=atan2((A^2+B^2+a2^2-a3^2),sqrt((4*a2^2*(A^2+B^2))-(A^2+B^2+a2^2-a3^2)^2))-atan2(A,B);
            %theta2=atan2((A^2+B^2+a2^2-a3^2)/(2*a2*nn),sqrt(1-((A^2+B^2+a2^2-a3^2)/(2*a2*nn))^2))-atan2(A/nn,B/nn);
            theta2=atan2(xx1,yy1)-atan2(A/nn,B/nn);
            xx6=pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234);
            yy6=px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234);
            theta23=atan2(xx6/a3,yy6/a3);
            %theta23=atan2(pz-d1+d5*cos(theta234)-a2*sin(theta2)+d6*sin(theta5)*sin(theta234),px*cos(theta1)+py*sin(theta1)-d5*sin(theta234)-a2*cos(theta2)+d6*sin(theta5)*cos(theta234));
            theta3=theta23-theta2;
            theta4=theta234-theta23;
end

p=[theta1,theta2,theta3,theta4,theta5,theta6];
%p=[theta1*180/pi,theta2*180/pi,theta3*180/pi,theta4*180/pi,theta5*180/pi,theta6*180/pi];
end