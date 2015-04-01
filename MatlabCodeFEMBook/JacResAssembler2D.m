function [J,r] = JacResAssembler2D(p,e,t,xi,Afcn,Ffcn)
i=t(1,:); j=t(2,:); k=t(3,:); % triangle vertices
xc=(p(1,i)+p(1,j)+p(1,k))/3; % triangle centroids
yc=(p(2,i)+p(2,j)+p(2,k))/3;
% Evaluate u, a, a', and f.
tiny=1.e-8;
xic=(xi(i)+xi(j)+xi(k))/3;
a0=Afcn(xic); % a(u)
da=Afcn(xic+tiny); % a(u+tiny)
da=(da-a0)/tiny; % da(u)/du
ff=Ffcn(xc,yc);
% Assemble Jacobian and residual.
[Aa ,unused,b]=assema(p,t,a0',0,ff);
[Ada,unused]  =assema(p,t,da',0,0);
J=diag(Ada*xi)+Aa; % Jacobian
   r=b-Aa*xi; % residual
   % Enforce zero Dirichlet BC.
   fixed=unique([e(1,:) e(2,:)]); % boundary nodes
   for i=1:length(fixed)
     n=fixed(i); % a boundary node
     J(n,:)=0; % zero out row n of the Jacobian, J
     J(n,n)=1; % set diagonal entry J(n,n) to 1
     r(n)=0;   % set residual entry r(n) to 0
   end
