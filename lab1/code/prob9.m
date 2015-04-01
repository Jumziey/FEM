close all; clear all;
h = 0.1;
k = @(x,y) 10^6;
g = @(x,y) 0;
f = @(x,y) 2*pi^2*sin(pi*x).*sin(pi*y);
geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';

[p,t,U,A,R,b,r] = My2DPoissonSolver(geom,h,f,k,g);

subplot(2,1,1)
pdesurf(p,t,U);
title('Numerical Solution of -\Delta u = 2\pi^2sin(\pi x)sin(\pi y)')
subplot(2,1,2)
spy(A);
title('Sparsity pattern of A')

a = max(max(abs(A-A')));
disp(sprintf('A-A` non zeros = %d', nnz(a)));


eigsA = eigs(A)
eigsApR = eigs(A+R)
