function TransportSolver2D()
epsilon=0.1; % diffusion parameter
[p,e,t]=initmesh('squareg','hmax',0.05); % mesh
np=size(p,2); % number of nodes
[A,unused,b]=assema(p,t,1,0,1); % diffusion matrix A
                                % load vector b
bx=ones(np,1); by=ones(np,1); % convection field
C=ConvectionAssembler2D(p,t,bx,by); % convection matrix C
fixed=unique([e(1,:) e(2,:)]); % boundary nodes
free=setdiff([1:np],fixed); % interior nodes
b=b(free); % modify b for BC
A=A(free,free); C=C(free,free); % modify A and C for BC
xi=zeros(np,1); % solution vector
xi(free)=(epsilon*A+C)\b; % solve for free node values
pdesurf(p,t,U) % plot u
