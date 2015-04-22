close all; clear all;
a = @(u) 0.1 + u.^2;
f = @(x,y) ones(1,length(x));
runs = 5;

geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';

subplot(1,2,1)
myNewtonSolver(geom,a,f,runs,1)

a = @(u) 0.1;
subplot(1,2,2)
myNewtonSolver(geom,a,f,runs,1 )
title('a=0.1')

subplot(1,2,1)
title(sprintf('The nonlinarity from u^2\n makes the hill fatter'))

