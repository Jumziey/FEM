function Ex415()
% set up geometry
g = Rectg(0,0,1,1);
% create initial mesh
[p,e,t] = initmesh(g,'hmax',1000);
% while not too many elements, do
while size(t,2) < 10000
  % assemble stiffness matrix A, and load vector b
  i = t(1,:); j = t(2,:); k = t(3,:);
  x = (p(1,i)+p(1,j)+p(1,k))/3;
  y = (p(2,i)+p(2,j)+p(2,k))/3;
  f = Foo3(x,y);
  [A,unused,b] = assema(p,t,1,0,f);
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
  eta = pdejmps(p,t,1,0,f,xi,1,1,1);
  % choose a selection criteria
  tol = 0.8*max(eta);
  % select elements for refinement
  elements = find(eta > tol)';
  % refine elements using regular refinement
  [p,e,t] = refinemesh(g,p,e,t,elements,'regular');
  figure(2), pdemesh(p,e,t)
end

[X,Y] = meshgrid(0:0.02:1);
U=X.*(1-X).^2.*(exp(10.*X.^2)-1).*Y.*(1-Y).^2.*(exp(10.*Y.^2)-1);
figure(3), surf(X,Y,U)


