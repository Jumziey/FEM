function PiccardBiStableSolver2D()
g=Rectg(0,0,1,1);
[p,e,t]=initmesh(g,'hmax',0.025);
x=p(1,:)'; y=p(2,:)';
xi_old=cos(2*pi*x.^2).*cos(2*pi*y.^2); % IC
xi_new=xi_old;
dt=0.1; % time step
epsilon=0.01;
[A,M]=assema(p,t,1,1,0);
for l=1:100 % time loop
  for k=1:3 % non-linear loop
    xi_tmp=xi_new;
    b=M*(xi_tmp-xi_tmp.^3);
    xi_new=(M+dt*epsilon*A)\(M*xi_old+dt*b);
       fixpterror=norm(xi_tmp-xi_new)
     end
     xi_old=xi_new;
     pdesurf(p,t,xi_new)
     axis([0,1,0,1,-1,1]), caxis([-1,1]), pause(.1);
   end
