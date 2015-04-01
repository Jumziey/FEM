function BackwardEulerHeatSolver1D()
h = 0.01; % mesh size
x = 0:h:1; % mesh
m = 100; % number of time levels
T = 0.5; % final time
t = linspace(0,T,m+1); % time grid
xi = 0.5-abs(0.5-x)'; % inital condition 
kappa = [1.e+6 1.e+6]; % Robin BC parameters 
g = [0 0]; 
one = inline('1','x'); % dummy 
twox = inline('2*x','x'); % load f=2x
A = StiffnessAssembler1D(x,one,kappa); % stiffness matrix
M = MassAssembler1D(x); % mass matrix
b = LoadAssembler1D(x,twox,kappa,g); % load vector
for l = 1:m % time loop
  k = t(l+1) - t(l); % time step; 
  xi = (M + k*A)\(M*xi + k*b); % backward Euler method
  plot(x,xi), axis([0 1 0 0.5]), pause(0.1) % plot 
end
