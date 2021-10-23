%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%EKF卡尔曼滤波，完成扩展Kalman滤波对目标状态的估计;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = KalmanFilter(t,x,u,flag)
global Xekf;
global Zdist;    %观测信息

Q=diag([0.01,0.04]);
R=1;


%输入参数
%   t,x,u分别对应时间/状态/输入信号 
%   flag为标志位
%   simStateCompliance采用内建模块的方法保存和重建连续状态、工作向量等

%输出参数
%   sys为一个通用的返回参数值，其数值根据flag的不同而不同
%   x0为状态初始数值
%   一般str=[]
%   ts为一个两列的矩阵，包含采样时间和偏移量两个参数

switch flag

  case 0   % 系统进行初始化，调用mdlInitializeSizeshan函数
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
    
  case 2   % 更新离散状态变量
    sys=mdlUpdate(t,x,u,Q,R);
    
  case 3   %计算S函数的输出
    sys=mdlOutputs(t,x,u);

  case {1,4}  % 计算下一仿真时刻
    sys=[];

  case 9  % 仿真结束
      
      
    save('Zdist','Zdist');  %将结果保存成mat文件可以load读进来
    save('Xekf','Xekf');

 otherwise  %其他情况用户自定义
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% 系统初始化子函数

sizes = simsizes;

sizes.NumContStates  = 0;   %连续状态个数
sizes.NumDiscStates  = 2;   %离散状态个数
sizes.NumOutputs     = 2;   %输出维数
sizes.NumInputs      = 1;   %输入维数
sizes.DirFeedthrough = 0;   %是否直接馈通
sizes.NumSampleTimes = 1;   %采样时间个数，至少一个

sys = simsizes(sizes);     %将size结构传到sys中

% initialize the initial conditions
x0  = [0,0]';

% str is always an empty matrix
str = [];

% initialize the array of sample times
ts  = [-1 0];
% 表示该模块采样时间继承其前的模块采样时间设置

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'DefaultSimState';

global Zdist;
Zdist=[];
global Xekf;
Xekf=[x0];
global P;
P=zeros(2,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%进行离散状态变量的更新
function sys=mdlUpdate(t,x,u,Q,R)
global Zdist;
global Xekf;
global P;

Zdist=[Zdist,u];   %保存观测信息

%开始用EKF对状态更新%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0=0;y0=0;

Xold=Xekf(:,length(Xekf(1,:)));
Xpre=Statequation(Xold);

%观测预测
Zpre=jisuandistance(Xpre);

%求出F和H

F=[1,0;0.1*cos(0.1*Xpre(1,1)),1];
H=[(Xpre(1,1)-x0)/Zpre,(Xpre(2,1)-y0)/Zpre];


    Ppre=F*P*F'+Q;                %协方差预测
    K=Ppre*H'*inv(H*Ppre*H'+R);   %计算卡尔曼增益

    Xnew=Xpre+K*(u-Zpre);         %状态更新
    P=(eye(2)-K*H)*Ppre;          %协方差更新
    
     Xekf=[Xekf,Xnew];
     
sys = Xnew;   %将计算的结果返回主函数

     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%求取系统的输出信号
function sys=mdlOutputs(t,x,u)

sys =x;
%把算得的模块输出向量赋给sys

%求取系统的输出信号
function sys=mdlTerminate(t,x,u)

sys =[];

