%Tabsize=2
clear all; close all;
%settings for the problem
k= @(x,y) 10^6;
g= @(x,y) 0;
% 1. Create initial mesh.jkudbheo
[p,e,t]=initmesh(@squareg,'hmax',1);
MAXNEL = 10000;
syms xVar yVar;
c = 100;
uSym = -exp(-c*(xVar.^2+yVar.^2));
fSym = laplace(uSym,xVar)+laplace(uSym,yVar);
f = matlabFunction(fSym);
iter =0;
while size(t,2) < MAXNEL
	% 2. Compute finite element solution U.
	[A,R,b,r] = assemble(p,e,t,f,k,g);
	U = (A+R)\(b+r);
	subplot(2,3,1)
	pdesurf(p,t,U)
	% 2.5 Calculate f values
	i=t(1,:); j=t(2,:); q=t(3,:);
	x=(p(1,i)+p(1,j)+p(1,q))/3;
	y=(p(2,i)+p(2,j)+p(2,q))/3;
	% 3. Evaluate element indicator.
	eta = pdejmps(p,t,1,0,f(x,y),U,1,1,1);
	% 4. Refine mesh.
	epsilon = 0.9*max(eta);
	doh = find(eta>=epsilon);
	subplot(2,3,2)
	hold off
	pdemesh(p,e,t);
	hold on
	nodes = t(1:3,doh);
	pv = p(:,nodes);
	plot(pv(1,:), pv(2,:), 'rx')

	[p,e,t] = refinemesh(@squareg,p,e,t,doh');
	subplot(2,3,3)
	pdemesh(p,e,t)
	drawnow
end
eta1 = eta;
title(sprintf('Maximum error in the adpitivively refined mesh: %g', max(eta1)))
subplot(2,3,1)
title('I wonder which one is better... ^^')

disp('Had a weird thing happen when only one triangle was above or equal 0.9*max(eta) and then refinemesh did not wanna refine that mesh, using circleg')

[p,e,t]=initmesh(@squareg,'hmax',1);
while size(t,2) < MAXNEL
	% 2. Compute finite element solution U.
	[A,R,b,r] = assemble(p,e,t,f,k,g);
	U = (A+R)\(b+r);
	subplot(2,3,4)
	pdesurf(p,t,U)
	% 2.5 Calculate f values
	i=t(1,:); j=t(2,:); q=t(3,:);
	x=(p(1,i)+p(1,j)+p(1,q))/3;
	y=(p(2,i)+p(2,j)+p(2,q))/3;
	% 3. Evaluate element indicator.
	eta = pdejmps(p,t,1,0,f(x,y),U,1,1,1);
	% 4. Refine mesh.
	epsilon = 0.9*max(eta);
	doh = find(eta>=epsilon);
	subplot(2,3,5)
	pdemesh(p,e,t);
	[p,e,t] = refinemesh(@squareg,p,e,t);
	subplot(2,3,6)
	pdemesh(p,e,t)
	drawnow
end
eta2 = eta;
title(sprintf('Maxmimum error in the stupidely refined mesh: %g', max(eta2)))

subplot(2,3,4)
title('The adaptively refined mesh is better by an order of magnitude! :D')
