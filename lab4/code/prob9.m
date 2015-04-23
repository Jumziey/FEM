close all; clear all;
geom = [2 0 1 0 0 1 0;
				2 1 1 0 1 1 0;
				2 1 0 1 1 1 0;
				2 0 0 1 0 1 0]';
[p,e,t]=initmesh(geom);
N=size(p,2);
eta =rand(N,1); % initial rabbit population
zeta=rand(N,1); %fox
Npred = [];
Nprey = [];

[K,M,ununsed]=assema(p,t,1,1,0); % assemble K and M
dt=0.01; % time step
time=0;
while time < 20 % time loop
	eta_old=eta; zeta_old=zeta;
	for fixpt=1:2 % make two fixed point iterations
		eta =(M/dt+K)\(M/dt* eta_old+M*(eta.*(1-zeta)));
		zeta=(M/dt+K)\(M/dt*zeta_old+M*(zeta.*(eta-1)));
	end
	Nprey = [Nprey max(ones(length(M))*M*eta)];
	Npred = [Npred max(ones(length(M))*M*zeta)];
	time = time+dt;

end
subplot(1,2,1), pdesurf(p,t,eta), title('Rabbits')
subplot(1,2,2), pdesurf(p,t,zeta), title('Foxes')
figure(2)
plot([1:2000], Nprey)
hold on
plot([1:2000], Npred) 	
