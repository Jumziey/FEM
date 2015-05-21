close all; clear all;
E = 1; 
nu = 0.3;
rho = 1;
lambda = E*nu/((1+nu)*(1-2*nu)); 
mu=E/(2*(1+nu));

%initmesh
[p,e,t] = initmesh('lshapeg','hmax', 0.1);
%pdemesh(p,e,t)

%getsystem
zero = @(x,y) [0,0];
[K,M,F] = assembleSolidMechanics(p,e,t,lambda,mu,rho,zero);


%Enforcing B.C.
for i=1:size(p,2)
	x=p(1,i); y=p(2,i);
	if x==0
		K(2*i-1,2*i-1)=1.e+6; K(2*i,2*i)=1.e+6;
	end
end

%Find eigenvalues and vibrational modes of the system
opts.isreal=1; opts.issym=1;
[phi,omega2]=eigs(K,M,10,1.e-6,opts);

%Animation!
omega=sqrt(omega2);
time = 1:0.01:2;
em = 10;
pori = p;
for T = time
	p(1,:) = pori(1,:)+0.1*phi(1:2:end,em)'*sin(omega(em,em)*T); %X dir
	p(2,:) = pori(2,:)+0.1*phi(2:2:end,em)'*sin(omega(em,em)*T); %Y dir
	pdemesh(p,e,t)
	drawnow
end
