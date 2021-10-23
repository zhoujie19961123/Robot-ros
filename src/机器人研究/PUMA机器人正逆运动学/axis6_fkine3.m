function p = axis6_fkine3(theta0,theta1,theta2,theta3,theta4,theta5,x,y,z)
%T1
t1 = [
    cosd(theta0) -sind(theta0) 0 0;
    sind(theta0) cosd(theta0) 0 0;
    0 0 1 0;
    0 0 0 1
    ];
%T2
t2 = [
    0 0 1 0;
    -sind(theta1) -cosd(theta1) 0 0;
    cosd(theta1) -sind(theta1) 0 0.178;
    0 0 0 1
    ];
%T3
t3 = [
    cosd(theta2) -sind(theta2) 0 0.205;
    sind(theta2) cosd(theta2) 0 0;
    0 0 1 0;
    0 0 0 1
    ];
%T4
t4 = [
    0, 0, 1, 0.105;
    -cosd(theta3)  sind(theta3) 0 0.000;
    -sind(theta3) -cosd(theta3) 0 0;
    0 0 0 1;
    ];
%T5
t5 = [
    sind(theta4)  cosd(theta4) 0 0;
    0 0 1 0;
    cosd(theta4) -sind(theta4) 0 0.105;
    0 0 0 1
    ];
%T6
t6 = [
    0   0 1 0.1315;
    cosd(theta5)  -sind(theta5) 0 0;
    sind(theta5)  cosd(theta5) 0 0;
    0 0 0 1
    ];

temp = t1*t2*t3*t4*t5*t6;
%==================================
P1 = [0 0 0];                           %关节1位置
P2 = [0 0 0.178];                       %关节2位置
P3 = t1*t2*[0.205;0;0;1];               %关节3位置
P4 = t1*t2*t3*[0.105;0.00;0;1];        %关节4位置
P5 = t1*t2*t3*t4*[0;0;0.105;1];         %关节5位置
P6 = t1*t2*t3*t4*t5*[0.1315;0;0;1];     %关节6位置
P7 = t1*t2*t3*t4*t5*t6*[0;0;0;1];       %关节7夹具位置

%==================================
plot3([P1(1) P2(1)],[P1(2) P2(2)],[P1(3) P2(3)],'b','LineWidth',3);
axis([-0.8 0.8 -0.8 0.8 0 0.8]);
hold on;
plot3([P2(1) P3(1)],[P2(2) P3(2)],[P2(3) P3(3)],'b','LineWidth',3);
plot3([P3(1) P4(1)],[P3(2) P4(2)],[P3(3) P4(3)],'b','LineWidth',3);
plot3([P4(1) P5(1)],[P4(2) P5(2)],[P4(3) P5(3)],'b','LineWidth',3);
plot3([P5(1) P6(1)],[P5(2) P6(2)],[P5(3) P6(3)],'b','LineWidth',3);
plot3([P6(1) P7(1)],[P6(2) P7(2)],[P6(3) P7(3)],'b','LineWidth',3);
plot3(P1(1),P1(2),P1(3),'r+','markersize',20);
plot3(P2(1),P2(2),P2(3),'r+','markersize',20);
plot3(P3(1),P3(2),P3(3),'r+','markersize',20);
plot3(P4(1),P4(2),P4(3),'r+','markersize',20);
plot3(P5(1),P5(2),P5(3),'r+','markersize',20);
plot3(P6(1),P6(2),P6(3),'r+','markersize',20);
plot3(P7(1),P7(2),P7(3),'r.','markersize',20);
plot3([0 0.6],[0 0],[0 0],'--b');
plot3([0 0],[0 0.6],[0 0],'--r');
plot3([0 0],[0 0],[0 0.6],'--g');
plot3([P6(1) P6(1)+0.2*temp(1,1)],[P6(2) P6(2)+0.2*temp(2,1)],[P6(3) P6(3)+0.2*temp(3,1)],'--b','LineWidth',2);
plot3([P6(1) P6(1)+0.2*temp(1,2)],[P6(2) P6(2)+0.2*temp(2,2)],[P6(3) P6(3)+0.2*temp(3,2)],'--r','LineWidth',2);
plot3([P6(1) P6(1)+0.2*temp(1,3)],[P6(2) P6(2)+0.2*temp(2,3)],[P6(3) P6(3)+0.2*temp(3,3)],'--g','LineWidth',2);
Pm = t1*[0;-0.15;0;1];
plot3([P1(1) Pm(1)],[P1(2) Pm(2)],[P1(3) Pm(3)],'k','LineWidth',3);
hold off;
grid on;

%=============================================
%Inverse Kinematics
%=============================================
% L0 = 0.178; L1 = 0.205; L2 = 0.105; L3 = 0.105; L4 = 0.1315;
% ax = temp(1,3); ay = temp(2,3); az = temp(3,3);
% px = temp(1,4); py = temp(2,4); pz = temp(3,4);
% nx = temp(1,1); ny = temp(2,1); nz = temp(3,1);
% ox = temp(1,2); oy = temp(2,2); oz = temp(3,2);
% %Itheta0
% a = L4*ax-px;
% b = py-L4*ay;
% if(b ~= 0)
	% Itheta0temp = atan(a/b)*180/3.1415926;
	% if(a >= 0 && b > 0)
		% Itheta01 = Itheta0temp-180;
		% Itheta02 = Itheta0temp;
	% elseif(a >= 0 && b < 0)
		% Itheta01 = Itheta0temp+180;
		% Itheta02 = Itheta0temp;	
	% elseif(a <= 0 && b > 0)
		% Itheta01 = Itheta0temp+180;
		% Itheta02 = Itheta0temp;
	% elseif(a <= 0 && b < 0)
		% Itheta01 = Itheta0temp-180;
		% Itheta02 = Itheta0temp;	
	% end
% else
	% if(a ~= 0)
		% Itheta01 = 90;
		% Itheta02 = -90;	
	% else
		% Itheta01 = 0;
		% Itheta02 = 180;		
	% end
% end
% if(Itheta01 < 0)
	% if(abs(Itheta01+360-sd(1)) < abs(Itheta01-sd(1)))
		% Itheta01 = Itheta01+360;
	% end
% else
	% if(abs(Itheta01-360-sd(1)) < abs(Itheta01-sd(1)))
		% Itheta01 = Itheta01-360;
	% end
% end
% if(Itheta02 < 0)
	% if(abs(Itheta02+360-sd(1)) < abs(Itheta02-sd(1)))
		% Itheta02 = Itheta02+360;
	% end
% else
	% if(abs(Itheta02-360-sd(1)) < abs(Itheta02-sd(1)))
		% Itheta02 = Itheta02-360;
	% end
% end
% % disp(['Itheta01 = ',num2str(Itheta01),' Itheta02 = ',num2str(Itheta02)]);

% %Itheta1 Itheta2
% a = pz-az*L4-L0;
% b = -(cosd(Itheta01)*py-L4*(cosd(Itheta01)*ay-sind(Itheta01)*ax)-sind(Itheta01)*px);
% Itheta21 = acos((a^2+b^2-L1^2-(L2+L3)^2)/(2*L1*(L2+L3)))*180/3.1415926;
% Itheta22 = -Itheta21;
% Itheta1temp1 = acos((a^2+b^2+L1^2-(L2+L3)^2)/(2*L1*sqrt(a^2+b^2)))*180/3.1415926;
% if(a == 0)
    % if(b > 0)
        % Itheta1temp = 90;
    % else
        % Itheta1temp = -90;
    % end
% elseif(a > 0)
    % Itheta1temp = atan(b/a)*180/3.1415926;
% else 
    % if(b > 0) Itheta1temp = -atan(b/a)*180/3.1415926+90;
    % else Itheta1temp = -atan(b/a)*180/3.1415926-90;
    % end
% end
% Itheta11 = Itheta1temp-Itheta1temp1;  %取值与Itheta2的两个值必须对应
% Itheta12 = Itheta1temp+Itheta1temp1;
% a = pz-az*L4-L0;
% b = -(cosd(Itheta02)*py-L4*(cosd(Itheta02)*ay-sind(Itheta02)*ax)-sind(Itheta02)*px);
% Itheta23 = acos((a^2+b^2-L1^2-(L2+L3)^2)/(2*L1*(L2+L3)))*180/3.1415926;
% Itheta24 = -Itheta23;
% Itheta1temp1 = acos((a^2+b^2+L1^2-(L2+L3)^2)/(2*L1*sqrt(a^2+b^2)))*180/3.1415926;
% if(a == 0)
    % if(b > 0)
        % Itheta1temp = 90;
    % else
        % Itheta1temp = -90;
    % end
% elseif(a > 0)
    % Itheta1temp = atan(b/a)*180/3.1415926;
% else 
    % if(b > 0) Itheta1temp = -atan(b/a)*180/3.1415926+90;
    % else Itheta1temp = -atan(b/a)*180/3.1415926-90;
    % end
% end
% Itheta13 = Itheta1temp-Itheta1temp1;  %取值与Itheta2的两个值必须对应
% Itheta14 = Itheta1temp+Itheta1temp1;
% % disp(['Itheta11 = ',num2str(Itheta11),' Itheta12 = ',num2str(Itheta12), ...
		% % ' Itheta13 = ',num2str(Itheta13),' Itheta14 = ',num2str(Itheta14)]);
% % disp(['Itheta21 = ',num2str(Itheta21),' Itheta22 = ',num2str(Itheta22), ...
		% % ' Itheta23 = ',num2str(Itheta23),' Itheta24 = ',num2str(Itheta24)]);
		
% %Itheta4
% d = az;
% c = cosd(Itheta01)*ay - sind(Itheta01)*ax;
% S12 = sind(Itheta11+Itheta21);
% C12 = cosd(Itheta11+Itheta21);
% Itheta41 = acos(C12*d-S12*c)*180/3.1415926;
% Itheta42 = -Itheta41;
% c = cosd(Itheta01)*ay - sind(Itheta01)*ax;
% S12 = sind(Itheta12+Itheta22);
% C12 = cosd(Itheta12+Itheta22);
% Itheta43 = acos(C12*d-S12*c)*180/3.1415926;
% Itheta44 = -Itheta43;
% c = cosd(Itheta02)*ay - sind(Itheta02)*ax;
% S12 = sind(Itheta13+Itheta23);
% C12 = cosd(Itheta13+Itheta23);
% Itheta45 = acos(C12*d-S12*c)*180/3.1415926;
% Itheta46 = -Itheta45;
% c = cosd(Itheta02)*ay - sind(Itheta02)*ax;
% S12 = sind(Itheta14+Itheta24);
% C12 = cosd(Itheta14+Itheta24);
% Itheta47 = acos(C12*d-S12*c)*180/3.1415926;
% Itheta48 = -Itheta47;		
		
% % Itheta3
% % 1
% S0 = sind(Itheta01); C0 = cosd(Itheta01);
% S1 = sind(Itheta11); C1 = cosd(Itheta11);
% S2 = sind(Itheta21); C2 = cosd(Itheta21);
% S12 = sind(Itheta11+Itheta21);
% C12 = cosd(Itheta11+Itheta21);
% a = (C0*px) + (S0*py);
% b = L1*S2 + (S0*px-C0*py)*C12 + (L0-pz)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta31 = te;
% elseif(a < 0 && b > 0)	
	% Itheta31 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta31 = te;
% elseif(a > 0 && b > 0)	
	% Itheta31 = te-180;
% end
% if(Itheta31 < 0) Itheta32 = Itheta31+180;
% else Itheta32 = Itheta31-180;
% end
% %2
% S0 = sind(Itheta01); C0 = cosd(Itheta01);
% S1 = sind(Itheta12); C1 = cosd(Itheta12);
% S2 = sind(Itheta22); C2 = cosd(Itheta22);
% S12 = sind(Itheta12+Itheta22);
% C12 = cosd(Itheta12+Itheta22);
% a = (C0*px) + (S0*py);
% b = L1*S2 + (S0*px-C0*py)*C12 + (L0-pz)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta33 = te;
% elseif(a < 0 && b > 0)	
	% Itheta33 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta33 = te;
% elseif(a > 0 && b > 0)	
	% Itheta33 = te-180;
% end
% if(Itheta33 < 0) Itheta34 = Itheta33+180;
% else Itheta34 = Itheta33-180;
% end
% %3
% S0 = sind(Itheta02); C0 = cosd(Itheta02);
% S1 = sind(Itheta13); C1 = cosd(Itheta13);
% S2 = sind(Itheta23); C2 = cosd(Itheta23);
% S12 = sind(Itheta13+Itheta23);
% C12 = cosd(Itheta13+Itheta23);
% a = (C0*px) + (S0*py);
% b = L1*S2 + (S0*px-C0*py)*C12 + (L0-pz)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta35 = te;
% elseif(a < 0 && b > 0)	
	% Itheta35 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta35 = te;
% elseif(a > 0 && b > 0)	
	% Itheta35 = te-180;
% end
% if(Itheta35 < 0) Itheta36 = Itheta35+180;
% else Itheta36 = Itheta35-180;
% end
% %4
% S0 = sind(Itheta02); C0 = cosd(Itheta02);
% S1 = sind(Itheta14); C1 = cosd(Itheta14);
% S2 = sind(Itheta24); C2 = cosd(Itheta24);
% S12 = sind(Itheta14+Itheta24);
% C12 = cosd(Itheta14+Itheta24);
% a = (C0*px) + (S0*py);
% b = L1*S2 + (S0*px-C0*py)*C12 + (L0-pz)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta37 = te;
% elseif(a < 0 && b > 0)	
	% Itheta37 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta37 = te;
% elseif(a > 0 && b > 0)	
	% Itheta37 = te-180;
% end
% if(Itheta37 < 0) Itheta38 = Itheta37+180;
% else Itheta38 = Itheta37-180;
% end
% % disp(['Itheta31 = ',num2str(Itheta31),' Itheta32 = ',num2str(Itheta32) ...
	  % % ' Itheta33 = ',num2str(Itheta33),' Itheta34 = ',num2str(Itheta34)]);
% % disp(['Itheta35 = ',num2str(Itheta35),' Itheta36 = ',num2str(Itheta36) ...
	  % % ' Itheta37 = ',num2str(Itheta37),' Itheta38 = ',num2str(Itheta38)]);	
% % disp(['Itheta41 = ',num2str(Itheta41),' Itheta42 = ',num2str(Itheta42), ...
	  % % ' Itheta43 = ',num2str(Itheta43),' Itheta44 = ',num2str(Itheta44)]);		
% % disp(['Itheta45 = ',num2str(Itheta45),' Itheta46 = ',num2str(Itheta46), ...
	  % % ' Itheta47 = ',num2str(Itheta47),' Itheta48 = ',num2str(Itheta48)]);		  
		
% %Itheta5
% %1
% S0 = sind(Itheta01); C0 = cosd(Itheta01);
% S12 = sind(Itheta11+Itheta21);
% C12 = cosd(Itheta11+Itheta21);
% a = oz*C12 + (S0*ox - C0*oy)*S12;
% b = -nz*C12 + (C0*ny - S0*nx)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta52 = te;
% elseif(a < 0 && b > 0)	
	% Itheta52 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta52 = te;
% elseif(a > 0 && b > 0)	
	% Itheta52 = te-180;
% end
% if(Itheta52 < 0) Itheta51 = Itheta52+180;
% else Itheta51 = Itheta52-180;
% end
% %2
% S0 = sind(Itheta01); C0 = cosd(Itheta01);
% S12 = sind(Itheta12+Itheta22);
% C12 = cosd(Itheta12+Itheta22);
% a = oz*C12 + (S0*ox - C0*oy)*S12;
% b = -nz*C12 + (C0*ny - S0*nx)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta54 = te;
% elseif(a < 0 && b > 0)	
	% Itheta54 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta54 = te;
% elseif(a > 0 && b > 0)	
	% Itheta54 = te-180;
% end
% if(Itheta54 < 0) Itheta53 = Itheta54+180;
% else Itheta53 = Itheta54-180;
% end
% %3
% S0 = sind(Itheta02); C0 = cosd(Itheta02);
% S12 = sind(Itheta13+Itheta23);
% C12 = cosd(Itheta13+Itheta23);
% a = oz*C12 + (S0*ox - C0*oy)*S12;
% b = -nz*C12 + (C0*ny - S0*nx)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta56 = te;
% elseif(a < 0 && b > 0)	
	% Itheta56 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta56 = te;
% elseif(a > 0 && b > 0)	
	% Itheta56 = te-180;
% end
% if(Itheta56 < 0) Itheta55 = Itheta56+180;
% else Itheta55 = Itheta56-180;
% end
% %4
% S0 = sind(Itheta02); C0 = cosd(Itheta02);
% S12 = sind(Itheta14+Itheta24);
% C12 = cosd(Itheta14+Itheta24);
% a = oz*C12 + (S0*ox - C0*oy)*S12;
% b = -nz*C12 + (C0*ny - S0*nx)*S12;
% te = atan(a/b)*180/pi;
% if(a < 0 && b < 0)
	% Itheta58 = te;
% elseif(a < 0 && b > 0)	
	% Itheta58 = te+180;
% elseif(a > 0 && b < 0)
	% Itheta58 = te;
% elseif(a > 0 && b > 0)	
	% Itheta58 = te-180;
% end
% if(Itheta58 < 0) Itheta57 = Itheta58+180;
% else Itheta57 = Itheta58-180;
% end
% disp(['Itheta51 = ',num2str(Itheta51),' Itheta52 = ',num2str(Itheta52), ...
	  % ' Itheta53 = ',num2str(Itheta53),' Itheta54 = ',num2str(Itheta54)]);		
% disp(['Itheta55 = ',num2str(Itheta55),' Itheta56 = ',num2str(Itheta56), ...
	  % ' Itheta57 = ',num2str(Itheta57),' Itheta58 = ',num2str(Itheta58)]);	


%s = axis6_ikine3(temp,1)
 p = temp



		
