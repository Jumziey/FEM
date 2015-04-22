close all; clear all;
f = @(x,y) ones(1,length(x));
runs = 5;

geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';



alpha = 1;
c = [1 0.1 0.075 0.05 0.01];
for i=1:length(c)
	subplot(2,3,i)
	a = @(u) c(i)+u.^2;
	myNewtonSolver(geom,a,f,runs,alpha)
	title(sprintf('\\epsilon = %.3f',c(i)))
end

figure(2)
alpha = 0.5;
c = [1 0.1 0.075 0.05 0.01]/2;
for i=1:length(c)
	subplot(2,3,i)
	a = @(u) c(i)+u.^2;
	myNewtonSolver(geom,a,f,runs,alpha)
	title(sprintf('\\epsilon = %.3f',c(i)))
end
