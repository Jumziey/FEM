close all; clear all;
k = @(x,y) 10^6;
g = @(x,y) 0;
f = @(x,y) 2*pi^2*sin(pi*x).*sin(pi*y);
geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';

[p,t,U,A,R] = My2DPoissonSolver(geom,f,k,g);
%pdesurf(p,t,U)

spy(A)

a = max(max(abs(A-A')));
disp(sprintf('A-A` non zeros = %d', nnz(a)));


