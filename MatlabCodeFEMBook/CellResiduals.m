function RK = CellResiduals(p,t,force)
nt=size(t,2); % number of elements
RK=zeros(nt,1); % allocate element residuals
for i=1:nt % loop over elements
  nodes=t(1:3,i); % nodes
  x=p(1,nodes); y=p(2,nodes); % node coordinates
  [area,ds]=Triutils(x,y); % area and side lengths
  f=force(mean(x),mean(y)); % force at element centroid
  h=max(ds); % local mesh size is max side length
  RK(i)=h*sqrt(dot(f,f)*area); % cell residual h|f|_K
end
