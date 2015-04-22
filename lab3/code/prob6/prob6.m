close all; clear all;
a = @(u) 1;
f = @(u) exp(-u);
runs = 5;

geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';

myNewtonSolver(geom,a,f,runs,1)
