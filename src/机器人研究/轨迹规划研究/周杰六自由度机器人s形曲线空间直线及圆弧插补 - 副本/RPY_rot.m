%RPY求位姿矩阵，输入为弧度制
function RPY=RPY_rot(a,o,n)
nx=cos(a)*cos(o);
ny=sin(a)*cos(o);
nz=-sin(o);
ox=cos(a)*sin(o)*sin(n)-sin(a)*cos(n);
oy=sin(a)*sin(o)*sin(n)+cos(a)*cos(n);
oz=cos(o)*sin(n);
ax=cos(a)*sin(o)*cos(n)+sin(a)*sin(n);
ay=sin(a)*sin(o)*cos(n)-cos(a)*sin(n);
az=cos(o)*cos(n);
RPY=[nx,ox,ax;
     ny,oy,ay;
     nz,oz,az];
end
