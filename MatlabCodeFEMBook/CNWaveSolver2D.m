function CNWaveSolver2D()
g = Dslitg(); % double slit geometry
h = 0.025; % mesh size
k = 0.005; % time step
T = 2; % final time
[p,e,t] = initmesh(g,'hmax',h);
np = size(p,2); % number of nodes
x = p(1,:)'; y = p(2,:)'; % node coordinates
fixed = find(x < -0.24999); % Dirichlet nodes
xi = zeros(np,1); % set zero IC  
eta = zeros(np,1);  
[A,M,b] = assema(p,t,1,1,0); % assemble A, M, and b
for l = 1:round(T/k) % time loop
  time = l*k;  
  LHS = [M -0.5*k*M;  0.5*k*A M]; % Crank-Nicholson
  rhs = [M  0.5*k*M; -0.5*k*A M]*[xi; eta] ...
        + [zeros(np,1); k*b]; 
  sol = LHS\rhs; 
  xi = sol(1:np); 
  eta = sol(np+1:end);
  xi(fixed) = 0.1*sin(8*pi*time); % set BC the ugly way
  pdesurf(p,t,xi), axis([-1 1 -1 1 -0.25 0.5]) % plot
  pause(0.1)
end