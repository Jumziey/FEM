clear all; close all;

geom = square(0,1,0,1);
[p,e,t]=initmesh(geom,'hmax',0.05);

np=size(p,2); nt=size(t,2);
z=zeros(np+nt,1);

[A,Bx,By,a] = assembleScalarFunc(p,e,t);

A_tot=[	1*A 0*A Bx z;
				0*A 1*A By z;
				Bx' By' sparse(np,np) a;
				z' z' a' 0];
b_tot = zeros(size(A_tot,1),1);

[A_tot,b_tot]=setbc2(p,e,t,A_tot,b_tot);

x_tot=A_tot\b_tot;

figure(1)
xi=x_tot(1:np); eta=x_tot(np+nt+1:2*np+nt);
pdeplot(p,e,t,'flowdata',[xi eta])
title('Velocity')

figure(2)
theta=x_tot(2*(np+nt)+1:end-1);
pdesurf(p,t,theta)
title('Pressure')
