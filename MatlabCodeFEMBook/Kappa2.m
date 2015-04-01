function k = Kappa2(x,y)
k=0;
if x<-1.99 % inflow
  k=1e6;
end
if sqrt(x^2+y^2)<1.01 % cylinder
  k=1e6;
end
if x>5.99 % outflow
  [bx,by]=FlowField(x,y);
  nx=1; ny=0; % normal components
  k=bx*nx+by*ny; % kappa = dot(b,n)
end
