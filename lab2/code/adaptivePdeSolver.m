%Tabsize=2
k= @(x,y) 10^6;
g= @(x,y) 0;
f = @(x,y)1/4 * (x.^2+y.^2).^(-3/4);
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
	f = zeros(1,size(t,2));
	i=t(1,:); j=t(2,:); k=t(3,:);
	x=(p(1,i)+p(1,j)+p(1,k))/3;
	y=(p(2,i)+p(2,j)+p(2,k))/3;
	% 3. Evaluate element indicator.
	eta = pdejmps(p,t,1,0,f(x,y),U,1,1,1);
	% 4. Refine mesh.
	epsilon = 0.9*max(eta);
	[p,e,t] = refinemesh(@cicrleg,p,e,t,find(eta>=epsilon));
	figure(2)
	pdemesh(p,e,t)
end


