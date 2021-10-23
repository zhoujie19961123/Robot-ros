%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%s函数实现对输入的信号滤波模板

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = SimuKalmanFilter(t,x,u,flag)

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
    
  case 1   % 计算连续状态变量的导数
    sys=mdlDerivatives(t,x,u);
    
  case 2   % 更新离散状态变量
    sys=mdlUpdate(t,x,u);
    
  case 3   %计算S函数的输出
    sys=mdlOutputs(t,x,u);

  case 4  % 计算下一仿真时刻
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  case 9  % 仿真结束
    sys=mdlTerminate(t,x,u);

 otherwise  %其他情况用户自定义
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% 系统初始化子函数

sizes = simsizes;

sizes.NumContStates  = 0;   %连续状态个数
sizes.NumDiscStates  = 1;   %离散状态个数
sizes.NumOutputs     = 1;   %输出个数
sizes.NumInputs      = 1;   %输入个数
sizes.DirFeedthrough = 1;   %是否直接馈通
sizes.NumSampleTimes = 1;   %采样时间个数，至少一个

sys = simsizes(sizes);     %将size结构传到sys中
global P; %定义协方差
P=5;


% initialize the initial conditions
x0  = 5000+sqrt(5)*randn;

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

%进行连续变量的更新
function sys=mdlDerivatives(t,x,u)

sys = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%进行离散状态变量的更新
function sys=mdlUpdate(t,x,u)
global P;
F=1;  %系统状态方程的系数矩阵
B=0;
H=1;  %观测方程的系数矩阵
Q=0;  %过程噪声方差值
R=5;  %测量噪声方差值
    
    xpre=F*x+B*u;                      %状态预测
    Ppre=F*P*F'+Q;                    %协方差预测
    Kg=Ppre*H'*inv(H*Ppre*H'+R);       %计算卡尔曼增益
    
    e=u-H*xpre;               %u是输入的观测值，在此计算新息
    xnew=xpre+Kg*e;          %状态更新
    P=(eye(1)-Kg*H)*Ppre;    %协方差更新
    
sys = xnew;   %将计算的结果返回主函数

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%求取系统的输出信号
function sys=mdlOutputs(t,x,u)

sys =x;
%把算得的模块输出向量赋给sys

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%计算下一仿真时刻，由sys返回
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    % 此处设置下一仿真时刻为1s之后.
sys = t + sampleTime;


%结束仿真子系统
function sys=mdlTerminate(t,x,u)

sys = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
