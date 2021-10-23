function [y]=hhfun(x,xx)
y=sqrt((x(1)-xx(1))^2+(x(3)-xx(2))^2);