function PoissonSolver1D()
h = 0.1; % mesh size
x = 2:h:8; % mesh
kappa = [1.e+6 0];
g = [-1 0];
A = StiffnessAssembler1D(x, @Conductivity, kappa);
b = SourceAssembler1D(x, @Source, kappa, g);
u = A\b;
plot(x,u)
