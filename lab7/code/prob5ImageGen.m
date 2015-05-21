

close all; clear all;
geom=channel();
[p,e,t]=initmesh(geom,'hmax',0.4);
dt=0.01; % time step
[R,mask,g]=bcs(p,e);
visc = linspace(0.1,0.005,20);
xiData = [];
etaData = [];
thetaData = [];
i=0;
for nu = visc
	i=i+1;
	[A,M,Bx,By]=assemble(p,e,t);
	np=size(p,2);
	xi=zeros(np,1); eta=zeros(np,1);
	
	for k=1:1000
		C=reassemble(p,e,t,xi,eta);
		xi =xi -dt*(nu*A+C)*xi ./M; xi =xi.*mask+g;
		eta=eta-dt*(nu*A+C)*eta./M; eta=eta.*mask;
		theta=(A+R)\-(Bx*xi+By*eta)/dt;
		xi =xi -dt*(Bx*theta)./M;
		eta=eta-dt*(By*theta)./M;
	end
	xiData= [xiData xi];
	etaData = [etaData eta];
	thetaData = [thetaData theta];
end
save('data.mat', 'xiData', 'etaData', 'thetaData')
