

close all; clear all;
geom=channel();
[p,e,t]=initmesh(geom,'hmax',0.4);
[A,M,Bx,By]=assemble(p,e,t);
np=size(p,2);
xi=zeros(np,1); eta=zeros(np,1);
dt=0.01; % time step
nu=0.005; % viscosity
[R,mask,g]=bcs(p,e);
for k=1:1000
	C=reassemble(p,e,t,xi,eta);
	xi =xi -dt*(nu*A+C)*xi ./M; xi =xi.*mask+g;
	eta=eta-dt*(nu*A+C)*eta./M; eta=eta.*mask;
	theta=(A+R)\-(Bx*xi+By*eta)/dt;
	xi =xi -dt*(Bx*theta)./M;
	eta=eta-dt*(By*theta)./M;
	subplot(2,1,1)
	pdeplot(p,e,t,'flowdata',[xi eta]),axis equal
	title(sprintf('Time: %f',dt*k))
	
	subplot(2,1,2)
	pdeplot(p,e,t, 'xydata', theta),axis equal
	title('Pressure')
	drawnow
end
