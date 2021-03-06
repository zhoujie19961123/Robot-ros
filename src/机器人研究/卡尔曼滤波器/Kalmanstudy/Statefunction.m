%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%s函数仿真系统的状态方程 X(k+1)=F*x(k)+G*w(k)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = SimuStatefunction(t,x,u,flag)

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
    sys=mdlUpdate(t,x,u);
    
  case 3   %计算S函数的输出
    sys=mdlOutputs(t,x,u);

  case {1,4,9} 
    sys=[];

 otherwise  %其他情况用户自定义
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% 系统初始化子函数

sizes = simsizes;  %一个辅助函数提供有关S函数的特定信息。这个信息包括输入、输出、状态的数量，以及其他块特征。

sizes.NumContStates  = 0;   %连续状态个数
sizes.NumDiscStates  = 4;   %离散状态维度
sizes.NumOutputs     = 4;   %输出的维度
sizes.NumInputs      = 2;   %输入维数，因为噪声是二维的
sizes.DirFeedthrough = 0;   %是否直接馈通
sizes.NumSampleTimes = 1;   %采样时间个数，至少一个

sys = simsizes(sizes);     %将size结构传到sys中

% initialize the initial conditions
x0  =[10,5,12,5]';     %初始状态值

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%进行离散状态变量的更新
function sys=mdlUpdate(t,x,u)

G=[0.5,1;1,0;0,0.5;0,1];
F=[1,1,0,0;0,1,0,0;0,0,1,1;0,0,0,1];
    
sys = F*x+G*u;   %状态更新

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
