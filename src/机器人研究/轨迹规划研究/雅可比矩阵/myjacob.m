%% 替换变量并代值计算
function J = myjacob(theta)
syms th1 th2 th3 th4 th5 th6;
angle = [th1, th2, th3, th4, th5, th6];
JT = jisuan(angle);
% 替换变量
JT1 = subs(JT, th1, theta(1));
JT2 = subs(JT1, th2, theta(2));
JT3 = subs(JT2, th3, theta(3));
JT4 = subs(JT3, th4, theta(4));
JT5 = subs(JT4, th5, theta(5));
J = subs(JT5, th6, theta(6));

digits(4)
J = vpa(J,8);

end
