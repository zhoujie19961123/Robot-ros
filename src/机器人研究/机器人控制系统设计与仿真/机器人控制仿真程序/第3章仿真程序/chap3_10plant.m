function [sys,x0,str,ts] = spacemodel(t,x,u,flag)

switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0.15;0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)   %Time-varying model
g=9.8;
m=1;
l=0.25;

M=4/3*m*l^2;
Vm=2.0;
G=m*g*l*cos(x(1));
F=1.3*sin(0.5*pi*t);

tol=u;

sys(1)=x(2);
sys(2)=1/M*(tol-Vm*x(2)-G-F);

function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);