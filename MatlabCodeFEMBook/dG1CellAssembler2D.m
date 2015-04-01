function [A,B] = dG1CellAssembler2D(p,t,force)
nt=size(t,2);
A=sparse(3*nt,3*nt); % stiffness matrix
B=zeros(3*nt,1); % load vector
for i=1:nt
  nodes=t(1:3,i);
  xv=p(1,nodes)'; 
  yv=p(2,nodes)';
  [area,b,c]=HatGradients(xv,yv);
  dofs=[1:3]+3*(i-1); % element degrees of freedom
  AK=(b*b'+c*c')*area;
  BK=force(mean(xv),mean(yv))*ones(3,1)/3*area;
  A(dofs,dofs)=A(dofs,dofs)+AK;
  B(dofs)=B(dofs)+BK;
end