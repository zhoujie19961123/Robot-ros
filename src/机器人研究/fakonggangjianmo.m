syms XV Kq1 PS Ct2 KC1 Ct1 VT Bete n A1 M Bp K s FL
aa=1/((VT/(2*Bete*(1+n^2)))*s+Ct1+KC1);
dd=1/(M*s^2+Bp*s+K);
wew=aa*A1-FL;
gs=wew*dd;
cc=gs/(1+gs*A1*s);
qqq=XV*Kq1-PS*Ct2;
yyy=qqq*cc
