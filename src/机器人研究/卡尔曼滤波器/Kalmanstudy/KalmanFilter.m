%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%卡尔曼滤波，系统的状态方程为X(k+1)=F*x(k)+G*w(k);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = KalmanFilter(t,x,u,flag)
global Xkf;
global Z;

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

  case {1,4}  % 计算下一仿真时刻
    sys=[];

  case 9  % 仿真结束
      
      
    save('Zobserv','Z');  %将结果保存成mat文件可以load读进来
    save('Xkalman','Xkf');

 otherwise  %其他情况用户自定义
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% 系统初始化子函数

global P;
global Xkf;
global Z;
P=0.1*eye(4);

sizes = simsizes;

sizes.NumContStates  = 0;   %连续状态个数
sizes.NumDiscStates  = 4;   %离散状态个数
sizes.NumOutputs     = 4;   %输出个数
sizes.NumInputs      = 2;   %输入个数
sizes.DirFeedthrough = 0;   %是否直接馈通
sizes.NumSampleTimes = 1;   %采样时间个数，至少一个

sys = simsizes(sizes);     %将size结构传到sys中

Xkf=[];
Z=[];

% initialize the initial conditions
x0  = [10,5,12,5]';

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
global P;
global Xkf;
global Z;

F=[1,1,0,0;0,1,0,0;0,0,1,1;0,0,0,1];  %系统状态方程的系数矩阵
G=[0.5,0;1,0;0,0.5;0,1];              %过程噪声驱动矩阵
H=[1,0,0,0;0,0,1,0];                  %观测方程的系数矩阵
Q=diag([0.0001,0.0009]);                %过程噪声方差值
R=diag([0.04,0.04]);                    %测量噪声方差值
    
%卡尔曼滤波
    Xpre=F*x;                      %状态预测
    Ppre=F*P*F'+G*Q*G';            %协方差预测
    Kg=Ppre*H'*inv(H*Ppre*H'+R);   %计算卡尔曼增益
    
    e=u-H*Xpre;              %u是输入的观测值，在此计算新息
    Xnew=Xpre+Kg*e;          %状态更新
    P=(eye(4)-Kg*H)*Ppre;    %协方差更新
    
     
sys = Xnew;   %将计算的结果返回主函数

  %保存观测值和滤波结果
     Z=[Z,u];
     Xkf=[Xkf,Xnew];
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%求取系统的输出信号
function sys=mdlOutputs(t,x,u)

sys =x;
%把算得的模块输出向量赋给sys

%求取系统的输出信号
function sys=mdlTerminate(t,x,u)

sys =[];

