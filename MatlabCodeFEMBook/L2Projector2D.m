function L2Projector2D()
g = Rectg(0,0,1,1); % unit square
[p,e,t] = initmesh(g,'hmax',0.1); % create mesh
M = MassAssembler2D(p,t); % assemble mass matrix
b = LoadAssembler2D(p,t,@Foo2); % assemble load vector
Pf = M\b; % solve linear system
pdesurf(p,t,Pf) % plot projection
