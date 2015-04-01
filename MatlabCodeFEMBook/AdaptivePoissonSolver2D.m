function AdaptivePoissonSolver2D()
% set up geometry
g = 'cardg';
% create initial mesh
[p,e,t] = initmesh(g,'hmax',0.25);
% while not too many elements, do
while size(t,2) < 10000
  % assemble stiffness matrix A, and load vector b
  [A,unused,b] = assema(p,t,1,0,1);
  % get the number of nodes
  np = size(p,2);
  % enforce zero Dirichlet BC
  fixed = unique([e(1,:) e(2,:)]);
  free = setdiff([1:np],fixed);
  A = A(free,free);
  b = b(free);
  % solve for finite element solution
  xi = zeros(np,1);
  xi(free) = A\b;
  figure(1), pdesurf(p,t,xi)
  xlabel('x'), ylabel('y'), title('u_h')
  % compute element residuals
  eta = pdejmps(p,t,1,0,1,xi,1,1,1);
  % choose a selection criteria
  tol = 0.8*max(eta);
  % select elements for refinement
  elements = find(eta > tol)';
  % refine elements using regular refinement
  [p,e,t] = refinemesh(g,p,e,t,elements,'regular');
  figure(2), pdemesh(p,e,t)
end
