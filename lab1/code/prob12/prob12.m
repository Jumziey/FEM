close all; clear all;
k = @(x,y) 10^6;
g = @(x,y) 0;
f = @(x,y) 2*x.*(1-x) + 2*y.*(1-y);
bet =[20;20];
geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';



h = 0.05;
[p,t,U,A,R,b,r] = My2DPoissonSolver(geom,h,f,k,g,bet);
pdesurf(p,t,U);
title(sprintf('Numerical Solution of -\\Delta u = 2x(1-x)+2y(1-y) \n beta = [%d %d]', bet(1), bet(2)))
