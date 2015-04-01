function NSChorinSolver()
channel=DFGg();
[p,e,t]=initmesh(channel,'hmax',0.25);
np=size(p,2);
x=p(1,:); y=p(2,:);


out=find(x>2.199); % nodes on outflow
wgts=zeros(np,1); % big weights
wgts(out)=1.e+6;
R=spdiags(wgts,0,np,np); % diagonal penalty matrix


in =find(x<0.001); % nodes on inflow
bnd=unique([e(1,:) e(2,:)]); % all nodes on boundary
bnd=setdiff(bnd,out); % remove outflow nodes
mask=ones(np,1); % a mask to identify no-slip nodes
mask(bnd)=0; % set mask for no-slip nodes to zero
x=x(in); % x-coordinate of nodes on inflow
y=y(in); % y-
Umax=0.3; % maximum inflow velocity
g=zeros(np,1); % no-slip values
g(in)=4*Umax*y.*(0.41-y)/0.41^2; % inflow profile


[A,unused,M]=assema(p,t,1,0,1);
Bx=ConvectionAssembler2D(p,t,ones(np,1),zeros(np,1));
By=ConvectionAssembler2D(p,t,zeros(np,1),ones(np,1));


dt=0.01; % time step
nu=0.001; % viscosity
V=zeros(np,1); % x-velocity
U=zeros(np,1); % y-
for n=1:100
  % assemble convection matrix
  C=ConvectionAssembler2D(p,t,U,V);
  % compute tentative velocity
  U=U-dt*(nu*A+C)*U./M;
  V=V-dt*(nu*A+C)*V./M;
  % enforce no-slip BC
  U=U.*mask+g;
  V=V.*mask;
  % solve PPE
  P=(A+R)\-(Bx*U+By*V)/dt;
  % update velocity
  U=U-dt*(Bx*P)./M;
  V=V-dt*(By*P)./M;
  pdeplot(p,e,t,'flowdata',[U V]),axis equal,pause(.1)
end
