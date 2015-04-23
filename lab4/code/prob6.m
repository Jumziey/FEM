close all; clear all;
c11 = @(x,y) 0;
c12 = @(x,y) 0;
c21 = @(x,y) 1;
c22 = @(x,y) 1;

f1 = @(x,y) 1;
f2 = @(x,y) 1;

geom = @squareg;

[p,t,eta,zeta] = funnyFunc(geom, c11, c22, c12, c21, f1, f2);
subplot(1,2,1), pdesurf(p,t,eta)
subplot(1,2,2), pdesurf(p,t,zeta)
