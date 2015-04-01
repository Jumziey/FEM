function NewtonPoissonSolver2D()
g=Rectg(0,0,1,1);
[p,e,t]=initmesh(g,'hmax',0.05); % create mesh
xi=zeros(size(p,2),1); % initial zero guess
for k=1:5 % non-linear loop
  [J,r]=JacResAssembler2D(p,e,t,xi,@Afcn,@Ffcn);
  d=J\r; % solve for correction
  xi=xi+d; % update solution
  sprintf('|d|=%f, |r|=%f', norm(d), norm(r))
end
pdesurf(p,t,xi)
