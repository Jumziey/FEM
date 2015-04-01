function L2Projector1D()
n = 5; % number of subintervals
h = 1/n; % mesh size
x = 0:h:1; % mesh
M = MassAssembler1D(x); % assemble mass
b = LoadAssembler1D(x,@Foo1); % assemble load
Pf = M\b; % solve linear system
plot(x,Pf) % plot L^2 projection
