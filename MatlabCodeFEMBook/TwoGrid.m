function TwoGrid()
nf=2*25-1; % number of fine nodes
nc=(nf-1)/2; %         coarse nodes
h=1/(nf+1); % mesh size
x=0:h:1; % mesh
e=ones(nf,1);
A=spdiags([-e 2*e -e],-1:1,nf,nf)/h; % fine stiffness matrix
b=ones(nf,1)*h; % load vector
u=zeros(nf,1); % solution guess
P=sparse(nf,nc); % prolongation matrix
for i=1:nc 
    P(2*i-1,i)=0.5;
    P(2*i,i)=1;
    P(2*i+1,i)=0.5;
end
R=0.5*P'; % prolongation matrix
RAP=R*A*P; % coarse stiffness matrix
for k=1:5 % outer iteration loop
    u=Richardson(A,u,b,4,0.25*h);
    r=R*(b-A*u); % residual
    e=RAP\r; % correction
    u=u+P*e; % solution update
end
plot(x,[0 u' 0]), xlabel('x'), ylabel('u_h') % plot
