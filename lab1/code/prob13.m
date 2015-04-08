close all; clear all;
k = @(x,y) 10^6;
g = @(x,y) 0;
f = @(x,y) 2*x.*(1-x) + 2*y.*(1-y);
geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';

syms x y;
u = @(x,y) x*(1-x) * y*(1-y);
disp('==========Compare==========');
laplaceAna = -laplacian(u,[x,y])
f
disp('===========================');

%Calculating analytical Energy norm on omega
gradU = gradient(u,[x y]);
gradUSquare = gradU(1)^2 + gradU(2)^2;
gusXint = int(gradUSquare,x,0,1);
EnergyNorm = int(gusXint,y,0,1);
disp(sprintf('Analytical Energy Norm: %s',strtrim(rats(double(EnergyNorm)))))
disp(sprintf('Or: %.10f', double(EnergyNorm)))


stepSizes = linspace(0.125, 0.03, 10);
for h = stepSizes
	[p,t,U,A,R,b,r] = My2DPoissonSolver(geom,h,f,k,g);
	Enum = U.'*A*U;
	disp(sprintf('Numerical Energy Norm with h=%f : %.20f, diff: %g',h,Enum,abs(Enum-double(EnergyNorm))))
end
