
%Ҫע��������޽Ƕȵı仯

function cita=hfun(X1,X0)

if X1(3,1)-X0(2,1)>=0      %y1-y0
    if X1(1,1)-X0(1,1)>0   %x1-x0
        cita=atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %��һ���޵ļ���
    elseif X1(1,1)-X0(1,1)==0 
        cita=pi/2;    
    else 
        cita=pi/2+atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %�ڶ�����
    end
else
    if X1(1,1)-X0(1,1)>0   %x1-x0
        cita=3*pi/2+atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %��������
    elseif X1(1,1)-X0(1,1)==0 
        cita=3*pi/2;
    else
        cita=pi+atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %��������
    end
end