%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%s����ʵ�ֶ�������ź��˲�ģ��

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = SimuKalmanFilter(t,x,u,flag)

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
    
  case 1   % ��������״̬�����ĵ���
    sys=mdlDerivatives(t,x,u);
    
  case 2   % ������ɢ״̬����
    sys=mdlUpdate(t,x,u);
    
  case 3   %����S���������
    sys=mdlOutputs(t,x,u);

  case 4  % ������һ����ʱ��
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  case 9  % �������
    sys=mdlTerminate(t,x,u);

 otherwise  %��������û��Զ���
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% ϵͳ��ʼ���Ӻ���

sizes = simsizes;

sizes.NumContStates  = 0;   %����״̬����
sizes.NumDiscStates  = 1;   %��ɢ״̬����
sizes.NumOutputs     = 1;   %�������
sizes.NumInputs      = 1;   %�������
sizes.DirFeedthrough = 1;   %�Ƿ�ֱ����ͨ
sizes.NumSampleTimes = 1;   %����ʱ�����������һ��

sys = simsizes(sizes);     %��size�ṹ����sys��
global P; %����Э����
P=5;


% initialize the initial conditions
x0  = 5000+sqrt(5)*randn;

% str is always an empty matrix
str = [];

% initialize the array of sample times
ts  = [-1 0];
% ��ʾ��ģ�����ʱ��̳���ǰ��ģ�����ʱ������

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'DefaultSimState';

%�������������ĸ���
function sys=mdlDerivatives(t,x,u)

sys = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ɢ״̬�����ĸ���
function sys=mdlUpdate(t,x,u)
global P;
F=1;  %ϵͳ״̬���̵�ϵ������
B=0;
H=1;  %�۲ⷽ�̵�ϵ������
Q=0;  %������������ֵ
R=5;  %������������ֵ
    
    xpre=F*x+B*u;                      %״̬Ԥ��
    Ppre=F*P*F'+Q;                    %Э����Ԥ��
    Kg=Ppre*H'*inv(H*Ppre*H'+R);       %���㿨��������
    
    e=u-H*xpre;               %u������Ĺ۲�ֵ���ڴ˼�����Ϣ
    xnew=xpre+Kg*e;          %״̬����
    P=(eye(1)-Kg*H)*Ppre;    %Э�������
    
sys = xnew;   %������Ľ������������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��ȡϵͳ������ź�
function sys=mdlOutputs(t,x,u)

sys =x;
%����õ�ģ�������������sys

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������һ����ʱ�̣���sys����
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    % �˴�������һ����ʱ��Ϊ1s֮��.
sys = t + sampleTime;


%����������ϵͳ
function sys=mdlTerminate(t,x,u)

sys = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
