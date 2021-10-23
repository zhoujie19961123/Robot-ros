% the input of program
alpha1=0;
beta1=0;
gamma1=0.5;
alpha2=0.5;
beta2=0.7;
gamma2=0;
alpha3=0;
beta3=0;
gamma3=0;


lx=100;
ly=100;
lz=0;
mx=150;
my=150;
mz=0;
nx=80;
ny=60;
nz=10;
thigh=412;
crus=385;
ankel=121.8;
center=250;

% joint angle of right leg

% syms alpha1 beta1 gamma1 alpha2 beta2 gamma2 alpha3 beta3 gamma3 lx ly lz
% mx my mz nx ny nz thigh crus ankel center;
% r11=cos(alpha1)*cos(beta1);
% r12=cos(alpha1)*sin(beta1)*sin(gamma1)-sin(alpha1)*cos(gamma1);
% r13=cos(alpha1)*sin(beta1)*cos(gamma1)+sin(alpha1)*sin(gamma1);
% r21=sin(alpha1)*cos(beta1);
% r22=sin(alpha1)*sin(beta1)*sin(gamma1)+cos(alpha1)*cos(gamma1);
% r23=sin(alpha1)*sin(beta1)*cos(gamma1)-cos(alpha1)*sin(gamma1);
% r31=-sin(beta1);
% r32=cos(beta1)*sin(gamma1);
% r33=cos(beta1)*cos(gamma1);
% T0t1=[r11 r12 r13 lx
%       r21 r22 r23 ly
%       r31 r32 r33 lz
%        0    0  0   1 ];
% 
% s11=cos(alpha2)*cos(beta2);
% s12=cos(alpha2)*sin(beta2)*sin(gamma2)-sin(alpha2)*cos(gamma2);
% s13=cos(alpha2)*sin(beta2)*cos(gamma2)+sin(alpha2)*sin(gamma2);
% s21=sin(alpha2)*cos(beta2);
% s22=sin(alpha2)*sin(beta2)*sin(gamma2)+cos(alpha2)*cos(gamma2);
% s23=sin(alpha2)*sin(beta2)*cos(gamma2)-cos(alpha2)*sin(gamma2);
% s31=-sin(beta2);
% s32=cos(beta2)*sin(gamma2);
% s33=cos(beta2)*cos(gamma2);
% T0t14=[s11 s12 s13 mx
%        s21 s22 s23 my
%        s31 s32 s33 mz
%         0    0   0  1 ];
% 
%    k=(inv(T0t1)*T0t14);

   k(1,4)=-sin(alpha1)*ly*cos(beta1)-cos(alpha1)*lx*cos(beta1)+cos(alpha1)*cos(beta1)*mx+sin(alpha1)*cos(beta1)*my+lz*sin(beta1)-sin(beta1)*mz;
   k(2,4)=cos(beta1)*sin(gamma1)*mz-cos(beta1)*lz*sin(gamma1)-cos(gamma1)*mx*sin(alpha1)+cos(gamma1)*my*cos(alpha1)+cos(gamma1)*sin(alpha1)*lx-cos(gamma1)*cos(alpha1)*ly+sin(beta1)*mx*cos(alpha1)*sin(gamma1)-sin(beta1)*lx*cos(alpha1)*sin(gamma1)-sin(beta1)*ly*sin(alpha1)*sin(gamma1)+sin(beta1)*my*sin(alpha1)*sin(gamma1);
   k(3,4)=cos(beta1)*cos(gamma1)*mz-cos(beta1)*lz*cos(gamma1)-sin(beta1)*ly*sin(alpha1)*cos(gamma1)-sin(beta1)*lx*cos(alpha1)*cos(gamma1)+sin(beta1)*cos(gamma1)*mx*cos(alpha1)+sin(beta1)*cos(gamma1)*my*sin(alpha1)-sin(alpha1)*lx*sin(gamma1)-my*cos(alpha1)*sin(gamma1)+mx*sin(alpha1)*sin(gamma1)+cos(alpha1)*ly*sin(gamma1);
 
   
a1=k(1,4)*k(1,4)+k(2,4)*k(2,4)+(k(3,4)-ankel)*(k(3,4)-ankel);

theta4=acos((a1-thigh*thigh-crus*crus)/(2*thigh*crus));
b1=-2*k(1,4)*(crus+thigh*cos(theta4));
c1=thigh*thigh+crus*crus+2*thigh*crus*cos(theta4);
d1=k(1,4)*k(1,4)-thigh*thigh*sin(theta4)*sin(theta4);

% theta4=acos((a1-thigh*thigh-crus*crus)/(2*thigh*crus));
theta3=asin((-b1+sqrt(b1*b1-4*c1*d1))/(2*a1));
theta2=-atan(k(2,4)/(k(3,4)-ankel));
theta7=alpha2-alpha1;
theta6=gamma2-gamma1-theta2;
theta5=beta2-beta1-theta3-theta4;
theta1=beta2-beta1-theta3-theta4-theta5;

% joint angle of left leg

% t11=cos(alpha3)*cos(beta3);
% t12=cos(alpha3)*sin(beta3)*sin(gamma3)-sin(alpha3)*cos(gamma3);
% t13=cos(alpha3)*sin(beta3)*cos(gamma3)+sin(alpha3)*sin(gamma3);
% t21=sin(alpha3)*cos(beta3);
% t22=sin(alpha3)*sin(beta3)*sin(gamma3)+cos(alpha3)*cos(gamma3);
% t23=sin(alpha3)*sin(beta3)*cos(gamma3)-cos(alpha3)*sin(gamma3);
% t31=-sin(beta3);
% t32=cos(beta3)*sin(gamma3);
% t33=cos(beta3)*cos(gamma3);
% T0t16=[t11 t12 t13 nx
%       t21 t22 t23  ny
%       t31 t32 t33  nz
%        0    0  0   1 ];
theta8=alpha3-alpha2;
% T8t15=[-sin(theta8) -cos(theta8) 0  0
%        -cos(theta8)  sin(theta8) 0  0
%                 0           0     -1  0
%                 0           0      0  1];
% T14t15=[1 0 0 0
%        0 1 0 center
%        0 0 1  0
%        0 0 0  1 ];
%    
%   h=(inv(T8t15)*inv(T0t14*T14t15)*T0t16);
  h(1,4)=-nz*cos(alpha3-alpha2)*cos(beta2)*sin(gamma2)+cos(alpha3-alpha2)*cos(beta2)*sin(gamma2)*mz+cos(alpha3-alpha2)*center-sin(beta2)*sin(alpha3-alpha2)*mz+sin(beta2)*nz*sin(alpha3-alpha2)+cos(gamma2)*cos(alpha2)*cos(alpha3-alpha2)*my+cos(gamma2)*nx*cos(alpha3-alpha2)*sin(alpha2)-cos(gamma2)*cos(alpha3-alpha2)*mx*sin(alpha2)-cos(gamma2)*cos(alpha2)*ny*cos(alpha3-alpha2)+cos(alpha2)*sin(alpha3-alpha2)*cos(beta2)*mx+sin(alpha3-alpha2)*sin(alpha2)*cos(beta2)*my-ny*sin(alpha3-alpha2)*sin(alpha2)*cos(beta2)-cos(alpha2)*nx*sin(alpha3-alpha2)*cos(beta2)+sin(beta2)*cos(alpha2)*cos(alpha3-alpha2)*mx*sin(gamma2)-sin(beta2)*cos(alpha2)*nx*cos(alpha3-alpha2)*sin(gamma2)-sin(beta2)*ny*cos(alpha3-alpha2)*sin(alpha2)*sin(gamma2)+sin(beta2)*cos(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*my;
  h(2,4)=sin(beta2)*cos(alpha2)*nx*sin(alpha3-alpha2)*sin(gamma2)-sin(beta2)*cos(alpha2)*sin(alpha3-alpha2)*mx*sin(gamma2)-sin(beta2)*sin(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*my+sin(beta2)*ny*sin(alpha3-alpha2)*sin(alpha2)*sin(gamma2)-sin(alpha3-alpha2)*center+cos(gamma2)*sin(alpha3-alpha2)*mx*sin(alpha2)-cos(gamma2)*cos(alpha2)*sin(alpha3-alpha2)*my+cos(gamma2)*cos(alpha2)*ny*sin(alpha3-alpha2)-cos(gamma2)*nx*sin(alpha3-alpha2)*sin(alpha2)+sin(beta2)*nz*cos(alpha3-alpha2)-sin(beta2)*cos(alpha3-alpha2)*mz+nz*sin(alpha3-alpha2)*cos(beta2)*sin(gamma2)-sin(alpha3-alpha2)*cos(beta2)*sin(gamma2)*mz+cos(alpha3-alpha2)*sin(alpha2)*cos(beta2)*my-ny*cos(alpha3-alpha2)*sin(alpha2)*cos(beta2)-cos(alpha2)*nx*cos(alpha3-alpha2)*cos(beta2)+cos(alpha2)*cos(alpha3-alpha2)*cos(beta2)*mx;
  h(3,4)=-cos(gamma2)*sin(beta2)*ny*sin(alpha2)+sin(beta2)*sin(alpha2)*cos(gamma2)*my-cos(gamma2)*sin(beta2)*nx*cos(alpha2)+sin(beta2)*mx*cos(alpha2)*cos(gamma2)+cos(beta2)*cos(gamma2)*mz-cos(beta2)*cos(gamma2)*nz+ny*cos(alpha2)*sin(gamma2)-nx*sin(alpha2)*sin(gamma2)-cos(alpha2)*sin(gamma2)*my+mx*sin(alpha2)*sin(gamma2);
  h(1,3)=-cos(alpha2)*sin(alpha3-alpha2)*cos(beta2)*sin(alpha3)*sin(gamma3)-cos(alpha2)*sin(alpha3-alpha2)*cos(beta2)*cos(alpha3)*sin(beta3)*cos(gamma3)+sin(alpha3-alpha2)*sin(alpha2)*cos(beta2)*cos(alpha3)*sin(gamma3)-sin(alpha3-alpha2)*sin(alpha2)*cos(beta2)*sin(alpha3)*sin(beta3)*cos(gamma3)-cos(beta3)*cos(gamma3)*cos(alpha3-alpha2)*cos(beta2)*sin(gamma2)+sin(beta2)*cos(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*cos(alpha3)*sin(gamma3)-sin(beta2)*cos(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*sin(alpha3)*sin(beta3)*cos(gamma3)-sin(beta2)*cos(alpha2)*cos(alpha3-alpha2)*sin(gamma2)*cos(alpha3)*sin(beta3)*cos(gamma3)-sin(beta2)*cos(alpha2)*cos(alpha3-alpha2)*sin(gamma2)*sin(alpha3)*sin(gamma3)+sin(beta2)*cos(beta3)*cos(gamma3)*sin(alpha3-alpha2)+cos(gamma2)*cos(alpha3-alpha2)*sin(alpha2)*cos(alpha3)*sin(beta3)*cos(gamma3)+cos(gamma2)*cos(alpha3-alpha2)*sin(alpha2)*sin(alpha3)*sin(gamma3)+cos(gamma2)*cos(alpha2)*cos(alpha3-alpha2)*cos(alpha3)*sin(gamma3)-cos(gamma2)*cos(alpha2)*cos(alpha3-alpha2)*sin(alpha3)*sin(beta3)*cos(gamma3);
  h(2,3)=cos(alpha3-alpha2)*sin(alpha2)*cos(beta2)*cos(alpha3)*sin(gamma3)-cos(alpha2)*cos(alpha3-alpha2)*cos(beta2)*sin(alpha3)*sin(gamma3)-cos(alpha3-alpha2)*sin(alpha2)*cos(beta2)*sin(alpha3)*sin(beta3)*cos(gamma3)-cos(alpha2)*cos(alpha3-alpha2)*cos(beta2)*cos(alpha3)*sin(beta3)*cos(gamma3)-cos(gamma2)*sin(alpha3-alpha2)*sin(alpha2)*cos(alpha3)*sin(beta3)*cos(gamma3)-cos(gamma2)*sin(alpha3-alpha2)*sin(alpha2)*sin(alpha3)*sin(gamma3)-cos(gamma2)*cos(alpha2)*sin(alpha3-alpha2)*cos(alpha3)*sin(gamma3)+cos(gamma2)*cos(alpha2)*sin(alpha3-alpha2)*sin(alpha3)*sin(beta3)*cos(gamma3)+sin(beta2)*cos(beta3)*cos(gamma3)*cos(alpha3-alpha2)+cos(beta3)*cos(gamma3)*sin(alpha3-alpha2)*cos(beta2)*sin(gamma2)+sin(beta2)*cos(alpha2)*sin(alpha3-alpha2)*sin(gamma2)*cos(alpha3)*sin(beta3)*cos(gamma3)-sin(beta2)*sin(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*cos(alpha3)*sin(gamma3)+sin(beta2)*sin(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*sin(alpha3)*sin(beta3)*cos(gamma3)+sin(beta2)*cos(alpha2)*sin(alpha3-alpha2)*sin(gamma2)*sin(alpha3)*sin(gamma3);
  h(1,3)=-cos(alpha2)*sin(alpha3-alpha2)*cos(beta2)*sin(alpha3)*sin(gamma3)-cos(alpha2)*sin(alpha3-alpha2)*cos(beta2)*cos(alpha3)*sin(beta3)*cos(gamma3)+sin(alpha3-alpha2)*sin(alpha2)*cos(beta2)*cos(alpha3)*sin(gamma3)-sin(alpha3-alpha2)*sin(alpha2)*cos(beta2)*sin(alpha3)*sin(beta3)*cos(gamma3)-cos(beta3)*cos(gamma3)*cos(alpha3-alpha2)*cos(beta2)*sin(gamma2)+sin(beta2)*cos(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*cos(alpha3)*sin(gamma3)-sin(beta2)*cos(alpha3-alpha2)*sin(alpha2)*sin(gamma2)*sin(alpha3)*sin(beta3)*cos(gamma3)-sin(beta2)*cos(alpha2)*cos(alpha3-alpha2)*sin(gamma2)*cos(alpha3)*sin(beta3)*cos(gamma3)-sin(beta2)*cos(alpha2)*cos(alpha3-alpha2)*sin(gamma2)*sin(alpha3)*sin(gamma3)+sin(beta2)*cos(beta3)*cos(gamma3)*sin(alpha3-alpha2)+cos(gamma2)*cos(alpha3-alpha2)*sin(alpha2)*cos(alpha3)*sin(beta3)*cos(gamma3)+cos(gamma2)*cos(alpha3-alpha2)*sin(alpha2)*sin(alpha3)*sin(gamma3)+cos(gamma2)*cos(alpha2)*cos(alpha3-alpha2)*cos(alpha3)*sin(gamma3)-cos(gamma2)*cos(alpha2)*cos(alpha3-alpha2)*sin(alpha3)*sin(beta3)*cos(gamma3);
  
r=-ankel*h(1,3);
s=-ankel*h(2,3);
t=-ankel*h(3,3);
a2=(h(1,4)-r)*(h(1,4)-r)+(h(2,4)-s)*(h(2,4)-s)+(h(3,4)-t)*(h(3,4)-t);
theta11=acos((a2-thigh*thigh-crus*crus)/(2*thigh*crus));
b2=-2*(h(2,4)-s)*(thigh+crus*cos(theta11));
c2=thigh*thigh+crus*crus+2*thigh*crus*cos(theta11);
d2=(h(2,4)-s)*(h(2,4)-s)-crus*crus*sin(theta11)*sin(theta11);


% theta11=acos((a2-thigh*thigh-crus*crus)/(2*thigh*crus));
theta10=asin((-b2+sqrt(b2*b2-4*c2*d2))/(2*c2));
theta9=asin((h(1,4)+ankel*h(1,3))/(crus*cos(theta10+theta11)+thigh*cos(theta10)));
% theta8=alpha3-alpha2;
theta12=beta3-beta2-theta10-theta11;
theta13=gamma3-gamma2-theta9;

theta=[ theta2
        theta3
        theta4
        theta5
        theta6
        theta7
        theta8
        theta9
        theta10
        theta11
        theta12
        theta13]




















