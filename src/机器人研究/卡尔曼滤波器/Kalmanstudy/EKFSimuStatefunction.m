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

global Xstate;
switch flag

  case 0   % ϵͳ���г�ʼ��������mdlInitializeSizeshan����
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
    
  case 2   % ������ɢ״̬����
    sys=mdlUpdate(t,x,u);
    
  case 3   %����S���������
    sys=mdlOutputs(t,x,u);

  case {1,4} 
    sys=[];

  case 9  %�������������״ֵ̬
     
      save('Xstate','Xstate');
      
 otherwise  %��������û��Զ���
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% ϵͳ��ʼ���Ӻ���

sizes = simsizes;  %һ�����������ṩ�й�S�������ض���Ϣ�������Ϣ�������롢�����״̬���������Լ�������������

sizes.NumContStates  = 0;   %����״̬����
sizes.NumDiscStates  = 2;   %��ɢ״̬ά��
sizes.NumOutputs     = 2;   %�����ά��
sizes.NumInputs      = 2;   %����ά������Ϊ�����Ƕ�ά��
sizes.DirFeedthrough = 0;   %�Ƿ�ֱ����ͨ
sizes.NumSampleTimes = 1;   %����ʱ�����������һ��

sys = simsizes(sizes);     %��size�ṹ����sys��

% initialize the initial conditions
x0  =[0,0]';     %��ʼ״ֵ̬

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

Xnew=Statequation(x)+u;

global Xstate;
Xstate=[Xstate,Xnew];
sys = Xnew;   %״̬����



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��ȡϵͳ������ź�
function sys=mdlOutputs(t,x,u)

sys =x;

