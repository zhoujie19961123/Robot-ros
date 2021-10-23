function [sys,x0,str,ts] = obser(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0=[0.1 0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
k1=400;
k2=800;

x1=u(1);
y=x1;

ut=u(3);
M=0.5;g=9.8;l=1;m=1;

A=[0 1;0 0];
b=[0 1]';
C=[1 0];
K=[k1 k2]';
fx=-1/2*m*g*l*sin(x1);
gx=1/M;

ye=x1-x(1);
D=2;
v=-D*sign(ye);

dx=A*x+b*(fx+gx*ut-v)+K*(y-C*x);

sys(1)=dx(1);
sys(2)=dx(2);
function sys=mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);