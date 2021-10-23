%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%EKF�������˲��������չKalman�˲���Ŀ��״̬�Ĺ���;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys,x0,str,ts,simStateCompliance] = KalmanFilter(t,x,u,flag)
global Xekf;
global Zdist;    %�۲���Ϣ

Q=diag([0.01,0.04]);
R=1;


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
    sys=mdlUpdate(t,x,u,Q,R);
    
  case 3   %����S���������
    sys=mdlOutputs(t,x,u);

  case {1,4}  % ������һ����ʱ��
    sys=[];

  case 9  % �������
      
      
    save('Zdist','Zdist');  %����������mat�ļ�����load������
    save('Xekf','Xekf');

 otherwise  %��������û��Զ���
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
% ϵͳ��ʼ���Ӻ���

sizes = simsizes;

sizes.NumContStates  = 0;   %����״̬����
sizes.NumDiscStates  = 2;   %��ɢ״̬����
sizes.NumOutputs     = 2;   %���ά��
sizes.NumInputs      = 1;   %����ά��
sizes.DirFeedthrough = 0;   %�Ƿ�ֱ����ͨ
sizes.NumSampleTimes = 1;   %����ʱ�����������һ��

sys = simsizes(sizes);     %��size�ṹ����sys��

% initialize the initial conditions
x0  = [0,0]';

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

global Zdist;
Zdist=[];
global Xekf;
Xekf=[x0];
global P;
P=zeros(2,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ɢ״̬�����ĸ���
function sys=mdlUpdate(t,x,u,Q,R)
global Zdist;
global Xekf;
global P;

Zdist=[Zdist,u];   %����۲���Ϣ

%��ʼ��EKF��״̬����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0=0;y0=0;

Xold=Xekf(:,length(Xekf(1,:)));
Xpre=Statequation(Xold);

%�۲�Ԥ��
Zpre=jisuandistance(Xpre);

%���F��H

F=[1,0;0.1*cos(0.1*Xpre(1,1)),1];
H=[(Xpre(1,1)-x0)/Zpre,(Xpre(2,1)-y0)/Zpre];


    Ppre=F*P*F'+Q;                %Э����Ԥ��
    K=Ppre*H'*inv(H*Ppre*H'+R);   %���㿨��������

    Xnew=Xpre+K*(u-Zpre);         %״̬����
    P=(eye(2)-K*H)*Ppre;          %Э�������
    
     Xekf=[Xekf,Xnew];
     
sys = Xnew;   %������Ľ������������

     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��ȡϵͳ������ź�
function sys=mdlOutputs(t,x,u)

sys =x;
%����õ�ģ�������������sys

%��ȡϵͳ������ź�
function sys=mdlTerminate(t,x,u)

sys =[];

