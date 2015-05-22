load('data.mat')

[p,e,t]=initmesh(channel(),'hmax',0.4);
i=0;
for nu=linspace(0.1,0.005,20)
	i=i+1;
	subplot(4,5,i)
	xi=xiData(:,i);
	eta=etaData(:,i);
	pdeplot(p,e,t,'flowdata',[xi eta]),axis equal
	title(sprintf('Viscosity: %f',nu))
end
