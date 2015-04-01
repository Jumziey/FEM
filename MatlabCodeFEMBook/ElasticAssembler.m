function [K,M,F] = ElasticAssembler(p,e,t,lambda,mu,force)
ndof=2*size(p,2); % total number of degrees of freedom
K=sparse(ndof,ndof); % allocate stiffness matrix
M=sparse(ndof,ndof); % allocate mass matrix
F=zeros(ndof,1); % allocate load vector
dofs=zeros(6,1); % allocate element degrees of freedom
for i=1:size(t,2) % assemly loop over elements
    nodes=t(1:3,i); % element nodes
    x=p(1,nodes); y=p(2,nodes); % node coordinates
    dofs(2:2:end)=2*nodes; % element degrees of freedom
    dofs(1:2:end)=2*nodes-1;
    f=force(x,y); % evaluate force at nodes
    KK=ElasticStiffness(x,y,lambda,mu); % element stiffness
    MK=ElasticMass(x,y); % element mass
    fK=[f(1,1) f(2,1) f(1,2) f(2,2) f(1,3) f(2,3)]';
    FK=MK*fK; % element load
    K(dofs,dofs)=K(dofs,dofs)+KK; % add to stiffness matrix
    M(dofs,dofs)=M(dofs,dofs)+MK; % add to mass matrix
    F(dofs)=F(dofs)+FK; % add to load vector
end
