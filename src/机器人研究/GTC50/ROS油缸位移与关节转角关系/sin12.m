 %syms x;
 %assume(0.9634<=x<=1.4694);
x=1.4694;
%x=0.96342;

GO3=0.265;
H03=1.22;
GH=1.2484;
HI=0.3325;
IJ=0.1436;
HJ=0.4531;
HO4=0.170;
JK=0.330;
KO4=0.430;
o1=acos((HI^2+HJ^2-IJ^2)/(2*HI*HJ));
o2=acos((H03^2+GH^2-GO3^2)/(2*H03*GH));
a1=acos((GH^2+HI^2-x^2)/(2*GH*HI));
a2=pi-o1-o2-a1;

JO4=abs(sqrt((HJ^2+HO4^2)-cos(a2)*2*HJ*HO4));
a3=acos((HO4^2+JO4^2-HJ^2)/(2*HO4*JO4));
a4=acos((JO4^2+KO4^2-JK^2)/(2*JO4*KO4));
y=(184.2-0.1388)*pi/180-a3-a4
ww=(a3+a4)*180/pi

