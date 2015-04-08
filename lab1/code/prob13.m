close all; clear all;
k = @(x,y) 10^6;
g = @(x,y) 0;
rho1 = @(x,y) [1 1 1];
c = 25;
rho2 = @(x,y) exp(-c*((x-0.5).^2 + y.^2)) - exp(-c*((x+0.5).^2 + y.^2));

h = 0.05;
[p,t,U,A,R,b,r] = My2DPoissonSolver(@circleg,h,rho1,k,g);
pdesurf(p,t,U);
title(sprintf('Numerical Solution of \n -\\Delta \\phi = 1'))

figure(2)
[p,t,U,A,R,b,r] = My2DPoissonSolver(@circleg,h,rho2,k,g);
pdesurf(p,t,U);
title(sprintf('Numerical Solution of \n-\\Delta \\phi = exp(-c*((x-0.5).^2 + y.^2)) - exp(-c*((x+0.5).^2 + y.^2))'))

