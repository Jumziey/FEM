function [P,S] = dG1EdgeAssembler2D(p,t,neighbours)
nt=size(t,2);
S=sparse(3*nt,3*nt); % flux matrix
P=sparse(3*nt,3*nt); % penalty matrix
edge2node=[2 3; 1 3; 1 2]; % edge-to-node lookup table
cmat=[2 0; 1 1; 0 2]/2; wvec=[1 4 1]/6; % Simpson's formula
for i=1:nt
  pnodes=t(1:3,i); % nodes on "plus" element
  xp=p(1,pnodes)'; 
  yp=p(2,pnodes)';
  [area,ds,nx,ny]=Triutils(xp,yp);
  for j=1:3 % loop over edges
    n=neighbours(i,j); % element neighbour
    if n>i, continue; end % only assemble once on each edge
    if n<0, n=i; end % boundary? 
    e2n=edge2node(j,:); % nodes on edge
    ex=cmat*xp(e2n); % x-coordinates of quadrature points
    ey=cmat*yp(e2n); % y-
    SE=zeros(6,6);  
    PE=zeros(6,6); 
    mnodes=t(1:3,n); % nodes on "minus" element
    xm=p(1,mnodes)'; 
    ym=p(2,mnodes)';
    for q=1:length(wvec) % quadrature loop on edge
      wxlen=wvec(q)*ds(j); % quadrature weight times edge length
      [vp,bp,cp]=HatCoefficients(xp,yp,ex(q),ey(q));
      [vm,bm,cm]=HatCoefficients(xm,ym,ex(q),ey(q));
      jump=[vp -vm]; % jump 
      avgdn=[nx(j)*bp+ny(j)*cp nx(j)*bm+ny(j)*cm]/2; % average
      PE=PE+jump'*jump*wxlen; 
      SE=SE+jump'*avgdn*wxlen;
    end
    dofs=[[1:3]+3*(i-1) [1:3]+3*(n-1)];
    if n==i % boundary
      PE=PE(1:3,1:3);
      SE=SE(1:3,1:3)*2; % no average on boundary
      dofs=dofs(1:3);
    end
    P(dofs,dofs)=P(dofs,dofs)+PE;
    S(dofs,dofs)=S(dofs,dofs)+SE;
  end
end
