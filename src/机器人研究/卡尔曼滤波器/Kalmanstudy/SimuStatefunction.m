%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%s��������ϵͳ��״̬���� X(k+1)=F*x(k)+G*w(k)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = SimuStatefunction(t,x,u,flag)

%�������
%   t,x,u�ֱ��Ӧʱ��/״̬/�����ź� 
%   flagΪ��־λ
%   simStateCompliance�����ڽ�ģ��ķ���������ؽ�����״̬������������

%�������
%   sysΪһ��ͨ�õķ��ز���ֵ������ֵ����flag�Ĳ�ͬ����ͬ
%   x0Ϊ״̬��ʼ��ֵ
%   һ��str=[]
%   tsΪһ�����еľ��󣬰�������ʱ���ƫ������������


switch flag

  case 0   % ϵͳ���г�ʼ��������mdlInitializeSizeshan����
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
    
  case 2   % ������ɢ״̬����
    sys=mdlUpdate(t,x,u);
    
  case 3   %����S���������
    sys=mdlOutputs(t,x,u);

  case {1,4,9} 
    sys=[];


      
 otherwise  %��������û��Զ���
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% ϵͳ��ʼ���Ӻ���

sizes = simsizes;  %һ�����������ṩ�й�S�������ض���Ϣ�������Ϣ�������롢�����״̬���������Լ�������������

sizes.NumContStates  = 0;   %����״̬����
sizes.NumDiscStates  = 4;   %��ɢ״̬ά��
sizes.NumOutputs     = 4;   %�����ά��
sizes.NumInputs      = 2;   %����ά������Ϊ�����Ƕ�ά��
sizes.DirFeedthrough = 0;   %�Ƿ�ֱ����ͨ
sizes.NumSampleTimes = 1;   %����ʱ�����������һ��

sys = simsizes(sizes);     %��size�ṹ����sys��

% initialize the initial conditions
x0  =[9.4,8.5]';     %��ʼ״ֵ̬

% str is always an empty matrix
str = [];

% initialize the array of sample times
ts  = [-1 0];
% ��ʾ��ģ�����ʱ��̳���ǰ��ģ�����ʱ������

global Xstate;
Xstate=[];
Xstate=[Xstate,x0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'DefaultSimState';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ɢ״̬�����ĸ���
function sys=mdlUpdate(t,x,u)
G=[0.5,0:1,0:0,0.5:0,1];
F=[1,1,0,0;0,1,0,0;0,0,1,1;0,0,0,1];
Xnew=F*x+G*u;

global Xstate;
Xstate=[Xstate,X_next];
sys = X_next;   %״̬����



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��ȡϵͳ������ź�
function sys=mdlOutputs(t,x,u)

sys =x;
%����õ�ģ�������������sys

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������һ����ʱ�̣���sys����
%function sys=mdlGetTimeOfNextVarHit(t,x,u)

%sampleTime = 1;    % �˴�������һ����ʱ��Ϊ1s֮��.
%sys = t + sampleTime;


%����������ϵͳ
%function sys=mdlTerminate(t,x,u)

%sys = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
