%Tabsize=2
clear all; close all;
%settings for the problem
k= @(x,y) 10^6;
g= @(x,y) 0;
f= @(x,y) ones(1,length(x));
% 1. Create initial mesh.jkudbheo
L=0.1;
geom=[1 sqrt(1-L^2) 0 L 1 1 0 0 0 1;
1 0 -1 1 0 1 0 0 0 1;
1 -1 0 0 -1 1 0 0 0 1;
1 0 sqrt(1-L^2) -1 -L 1 0 0 0 1;
2 sqrt(1-L^2) 0 -L 0 1 0 0 0 0;
2 0 sqrt(1-L^2) 0 L 1 0 0 0 0]';
[p,e,t]=initmesh(geom,'hmax',1);

MAXNEL = 10000;
iter =0;
while size(t,2) < MAXNEL
	% 2. Compute finite element solution U.
	[A,R,b,r] = assemble(p,e,t,f,k,g);
	U = (A+R)\(b+r);
	subplot(1,3,1)
	pdesurf(p,t,U)
	axis equal
	% 2.5 Calculate f values
	i=t(1,:); j=t(2,:); q=t(3,:);
	x=(p(1,i)+p(1,j)+p(1,q))/3;
	y=(p(2,i)+p(2,j)+p(2,q))/3;
	% 3. Evaluate element indicator.
	eta = pdejmps(p,t,1,0,f(x,y),U,1,1,1);
	% 4. Refine mesh.
	epsilon = 0.8*max(eta);
	doh = find(eta>=epsilon);
	subplot(1,3,2)
	hold off
	pdemesh(p,e,t);
	hold on
	nodes = t(1:3,doh);
	pv = p(:,nodes);
	plot(pv(1,:), pv(2,:), 'rx')
	axis equal
	[p,e,t] = refinemesh(geom,p,e,t,doh');
	subplot(1,3,3)
	pdemesh(p,e,t)
	axis equal
	drawnow
end

