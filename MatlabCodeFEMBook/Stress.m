function sigma = Stress(mu,lambda,ux,uy,vx,vy,i)
divu=ux(i)+vy(i); % div u
dudx=[ux(i) uy(i); vx(i) vy(i)]; % grad u
epsilon=(dudx+dudx')/2; % strain
sigma=2*mu*epsilon+lambda*divu*eye(2); % stress
