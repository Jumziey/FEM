close all; clear all;
k = @(x,y) 10^6;
g = @(x,y) 0;
f = @(x,y) 2*pi^2*sin(pi*x).*sin(pi*y);
geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';

syms x y;
F = @(x,y) x*(1-x) * y*(1-y);
laplaceAna = -laplacian(F,[x,y])

gF = gradient(F,[x y]);
gFsquare = gF(1)^2 + gF(2)^2
integrate(gFsquare

%[p,t,U,A,R] = My2DPoissonSolver(geom,f,k,g);

