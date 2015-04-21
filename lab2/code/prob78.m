%Tabsize=2

%settings for the problem
k= @(x,y) 10^6;
g= @(x,y) 0;
f = @(x,y) 1/4 * (x.^2+y.^2 +10^-6).^(-3/4);
% 1. Create initial mesh.
[p,e,t]=initmesh(@circleg,'hmax',1);
MAXNEL = 10000;

while size(t,2) < MAXNEL
	% 2. Compute finite element solution U.
	[A,R,b,r] = assemble(p,e,t,f,k,g);
	U = (A+R)\(b+r);
	figure(1)
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
	figure(2)
	subplot(2,1,1)
	hold off
	pdemesh(p,e,t);
	hold on
	nodes = t(1:3,doh);
	pv = p(:,nodes);
	plot(pv(1,:), pv(2,:), 'rx')

	[p,e,t] = refinemesh(@circleg,p,e,t,doh');
	subplot(2,1,2)
	pdemesh(p,e,t)
	drawnow
end

disp('The clustering of the mesh refinement around origo is due to the singularity at origo')
