function [J,r] = JacResAssembler2D(p,e,t,u,Afcn,Ffcn)
i=t(1,:); j=t(2,:); k=t(3,:); % triangle vertices
xc=(p(1,i)+p(1,j)+p(1,k))/3; % triangle centroids
yc=(p(2,i)+p(2,j)+p(2,k))/3;
% Evaluate u, a, a', and f.
tiny=1.e-8;
uc=(u(i)+u(j)+u(k))/3;
a=Afcn(uc); % a(u)
da=Afcn(uc+tiny); % a(u+tiny)
da=(da-a)/tiny; % da(u)/du
f=Ffcn(xc,yc); % f
[ux,uy]=pdegrad(p,t,u); % grad u
np=size(p,2); nt=size(t,2);
% Assemble Jacobian and residual
J=sparse(np,np); r=zeros(np,1);
for i=1:nt
    nodes=t(1:3,i);
    x=p(1,nodes); y=p(2,nodes);
    [area,b,c]=HatGradients(x,y);
    rK=(f(i)*ones(3,1)/3-a(i)*(ux(i)*b+uy(i)*c))*area;
    JK=(a(i)*(b*b'+c*c')+da(i)*(ux(i)*b+uy(i)*c)*ones(1,3)/3)*area;
    J(nodes,nodes)=J(nodes,nodes)+JK;
    r(nodes)=r(nodes)+rK;
end
% Enforce zero Dirichlet BC.
fixed=unique([e(1,:) e(2,:)]); % boundary nodes
for i=1:length(fixed)
    n=fixed(i); % a boundary node
    J(n,:)=0; % zero out row n of the Jacobian, J
    J(n,n)=1; % set diagonal entry J(n,n) to 1
    r(n)=0;   % set residual entry r(n) to 0
end