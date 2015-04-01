function ForwardEulerHeatSolver1D()
h = 0.01; % mesh size
x = 0:h:1; % mesh
k = 0.1*h^2; % time step
T = 0.5; % final time
t = 0:k:T; % time grid
L = length(t) % number of time levels
xi = 0.5-abs(0.5-x)'; % inital condition 
kappa = [0 0]; % Robin BC parameters 
g = [0 0]; 
one = inline('1','x'); % dummy a=1
twox = inline('2*x','x'); % load f=2x
A = StiffnessAssembler1D(x,one,kappa); % stiffness matrix
M = MassAssembler1D(x); % mass matrix
b = LoadAssembler1D(x,twox,kappa,g); % load vector
D = sum(M,2); % lumped mass matrix diagonal
for l = 1:L % time loop
  xi = xi + k*(b - A*xi)./D; % forward Euler method
  xi(1) = 0; % enforce BC 
  xi(end) = 0; 
  plot(x,xi), axis([0 1 0 1]), pause(0.1) % plot 
end
