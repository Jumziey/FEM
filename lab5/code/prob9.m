

E = 1; 
nu = 0.3;
lambda = E*nu/((1+nu)*(1-2*nu)); 
mu=E/(2*(1+nu));

%initmesh
[p,e,t] = initmesh(unitsquare(),'hmax', 0.02);
%pdemesh(p,e,t)

%getsystem
[K,F] = assembleSolidMechanics(p,e,t,lambda,mu,forceFuncCreator(lambda,mu));

%Enforcing B.C.
for i=1:size(p,2)
	x=p(1,i); y=p(2,i);
	if x==0 || x==1 || y==0 || y==1
		K(2*i-1,2*i-1)=1.e+6; K(2*i,2*i)=1.e+6;
	end
end

d = K\F;
%Plot
pdesurf(p,t,d(2:2:end));

disp(sprintf('Calc Enorm: %g',d.'*F))
disp(sprintf('Ana Enorm: %g',(lambda+3*mu)/90))


