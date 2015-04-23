close all; clear all;
c11 = @(x,y) 1;
c12 = @(x,y) 0;
c21 = @(x,y) 0;
c22 = @(x,y) 1;

f1 = @(x,y) sin(x);
f2 = @(x,y) sin(x);

geom = @squareg;

[p,t,eta,zeta] = funnyFunc(geom, c11, c22, c12, c21, f1, f2);
subplot(2,2,1), pdesurf(p,t,eta)
subplot(2,2,2), pdesurf(p,t,zeta)

c22 = @(x,y) 10;
c21 = @(x,y) 1;

[p,t,eta,zeta] = funnyFunc(geom, c11, c22, c12, c21, f1, f2);
subplot(2,2,3), pdesurf(p,t,eta)
subplot(2,2,4), pdesurf(p,t,zeta)
