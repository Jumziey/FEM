function MyNewtonSolver(geom,a,f,runs, alpha)
[p,e,t]=initmesh(geom,'hmax',0.1);
u=zeros(size(p,2),1);
for k=1:runs
	[J,r]=jacres(p,e,t,u,a,f);
	d=J\r;
	u=u+alpha*d;
	sprintf('|d|=%f, |r|=%f', norm(d), norm(r))
end
pdesurf(p,t,u)
