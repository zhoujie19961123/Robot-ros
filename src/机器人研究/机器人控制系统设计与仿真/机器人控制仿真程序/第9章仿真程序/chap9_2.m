clear all;
close all;
load Fi_file;
Fi=F_iden;       %��̬Ħ�����ع���ֵ

w=[-1:0.05:1]';  %ȡһ��㶨ת��
N=size(w,1);

Size=100;   %��Ⱥ��ģ
CodeL=8;    %��������
MinX=zeros(CodeL,1);   %����������Χ
MaxX(1:2)=ones(2,1);
MaxX(3:4)=0.1*ones(2,1);
MaxX(5:6)=ones(2,1);
MaxX(7:8)=0.1*ones(2,1);
MaxX=MaxX';
for i=1:1:CodeL        %ʮ���Ƹ������
    kxi(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1); 
end

G=25000;   %����Ŵ�����
BsJ=0;
for kg=1:1:G
  time(kg)=kg;
if mod(kg,1000)==1
   kg
end
%*********���������Ӧ��ֵ**********
  for i=1:1:Size
    J=0;
    kx=kxi(i,:);  %��̬Ħ�������ı�ʶֵ
    Fcp=kx(1);
    Fsp=kx(2);
    alfap=kx(3);
    Vsp=kx(4);
    Fcm=kx(5);
    Fsm=kx(6);
    alfam=kx(7);
    Vsm=kx(8);
    for j=1:1:N   %Ħ�����صı�ʶֵ
      if j>21
         F_GA(j)=(Fcp+(Fsp-Fcp)*exp(-(w(j)/Vsp)^2))*sign(w(j))+alfap*w(j);
     elseif j<21
         F_GA(j)=(Fcm+(Fsm-Fcm)*exp(-(w(j)/Vsm)^2))*sign(w(j))+alfam*w(j);
     else
         F_GA(j)=0;         
      end
      Ji(j)=Fi(j)-F_GA(j);
      J=J+0.5*Ji(j)*Ji(j);
    end
      BsJi(i)=J;  %Ŀ�꺯��ֵ
  end
  [OderJi,IndexJi]=sort(BsJi);
  BestJ(kg)=OderJi(1);  %Ŀ�꺯����Сֵ
  Ji=BsJi;
  Cm=max(Ji);
% fi=Cm-Ji;  %������Ӧ��ֵ
  fi=1./Ji;
  [Oderfi,Indexfi]=sort(fi);
  Bestfi(kg)=Oderfi(Size);  %��������Ӧ��ֵ
  BestS=kxi(Indexfi(Size),:);
%***********ѡ�����***************
  fi_sum=sum(fi);
  fi_Size=(Oderfi/fi_sum)*Size;
  fi_S=floor(fi_Size); 
  r=Size-sum(fi_S);
  Rest=fi_Size-fi_S;
  [RestValue,Index]=sort(Rest);
  for i=Size:-1:Size-r+1
      fi_S(Index(i))=fi_S(Index(i))+1;
  end
  k=1;
  for i=Size:-1:1
     for j=1:1:fi_S(i) 
      TempE(k,:)=kxi(Indexfi(i),:);
        k=k+1;
     end
  end
%*************�������************
  Pc=0.90; %�������
  for i=1:2:(Size-1)
    temp=rand;
    if Pc>temp
      alfa=rand; %���淽��
      TempE(i,:)=alfa*kxi(i+1,:)+(1-alfa)*kxi(i,:);
      TempE(i+1,:)=alfa*kxi(i,:)+(1-alfa)*kxi(i+1,:);
    end
  end
  TempE(Size,:)=BestS;  %�������Ÿ���
  kxi=TempE;
%**************�������*************
  Pm=(0.20-(0.1-0.001)*kg/G);  %�������
  Pm_rand=rand(Size,CodeL);
  Mean=(MaxX + MinX)/2; 
  Dif=(MaxX-MinX);
  for i=1:1:Size
    for j=1:1:CodeL
       if Pm>Pm_rand(i,j)  %���췽��
          TempE(i,j)=Mean(j)+Dif(j)*(rand-0.5);
       end
    end
  end
  TempE(Size,:)=BestS; %�������Ÿ���
  kxi=TempE;
%**********************************
end

BestS %��Ѹ���
Best_J=BestJ(G) %���Ŀ�꺯��ֵ

figure(1); %��ʶǰ���Stribeck����
plot(w,F,'xr');
hold on
plot(w,F_GA,'-b');
xlabel('Speed');ylabel('Friction moment');
legend('Practical value by Test','Identified value by GA');
hold off

figure(2); %���Ŀ�꺯��ֵ�仯����
plot(time,BestJ,'r');
xlabel('Times');ylabel('Best J');