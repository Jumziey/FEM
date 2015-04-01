function [A,M,F] = IsoP2StiffnessAssembler(p,t,force)
[rspts,qwgts]=Gausspoints(4); % quadrature rule
np=size(p,2); % number of nodes
nt=size(t,2); % number of elements
A=sparse(np,np); % allocate stiffness matrix
for i=1:nt % loop over elements
    nodes=t(1:6,i); % node numbers
    x=p(1,nodes); % node x-coordinates
    y=p(2,nodes); %      y-
    AK=zeros(6,6); % elements stiffness
    for q=1:length(qwgts) % quadrature loop
        r=rspts(q,1); % quadrature r-coordinate
        s=rspts(q,2); %            s-
        [S,dSdx,dSdy,detJ]=Isopmap(x,y,r,s,@P2shapes);
        wxarea=qwgts(q)*detJ/2; % weight times area
        AK=AK+(dSdx*dSdx'...
               +dSdy*dSdy')*wxarea; % element stiffness
    end
    A(nodes,nodes)=A(nodes,nodes)+AK;
end
