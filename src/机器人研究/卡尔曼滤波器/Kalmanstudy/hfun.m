
%要注意各个象限角度的变化

function cita=hfun(X1,X0)

if X1(3,1)-X0(2,1)>=0      %y1-y0
    if X1(1,1)-X0(1,1)>0   %x1-x0
        cita=atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %第一象限的计算
    elseif X1(1,1)-X0(1,1)==0 
        cita=pi/2;    
    else 
        cita=pi/2+atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %第二象限
    end
else
    if X1(1,1)-X0(1,1)>0   %x1-x0
        cita=3*pi/2+atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %第四象限
    elseif X1(1,1)-X0(1,1)==0 
        cita=3*pi/2;
    else
        cita=pi+atan(abs((X1(3,1)-X0(2,1))/(X1(1,1)-X0(1,1))));
        %第三象限
    end
end