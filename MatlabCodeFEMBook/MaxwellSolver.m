function MaxwellSolver()
dl=Scatterg();
[p,dummy,t]=initmesh(dl,'hmax',0.1);
neighbors = Tri2Tri(p,t);
e = Tri2Edge(p,t); 
ne = max(e(:));
nt = size(t,2);
A = sparse(ne,ne);
b = zeros(ne,1);
omega = 2*pi/1;
mu = 1; 
epsilon = 1;  
signs=2*((neighbors'<[1:nt; 1:nt; 1:nt])-1/2)
for i=1:size(t,2);
    nodes = t(1:3,i);
    x = p(1,nodes);
    y = p(2,nodes);
    edges = e(i,:);
    sigma = 0;
    sd=t(4,i);
    if sd==7 % cavity
        %
    elseif sd==2 | sd==9 % up down pml
        sigma=5*(abs(mean(y))-3)^4;
    elseif sd==6 | sd==8 % left right pml 
        sigma=5*(abs(mean(x))-3)^4;
    else
        sigma=5*(abs(mean(x))-3)^4+(abs(mean(y))-3)^4;  
    end
    kappa=sqrt(sqrt(-1)*sigma*omega-epsilon*omega^2);
    [AE,FE] = RotRot(x,y,signs(:,i),mu,kappa,[0,0]);
    A(edges,edges) = A(edges,edges) + AE;  
    b(edges) = b(edges) + FE;
end
[xmid,ymid,edges] = EdgeMidPoints(p,e,t);
fixed=[]; % fixed nodes
gvals=[];
hold on
for i=1:ne % loop over edges 
  r=edges(i); % edge or node number
  x=xmid(i); % node x-coordinate
  y=ymid(i); %      y- 
  if (sqrt(x^2+y^2)<1.001) % cylinder
      normal = -[x; y]/sqrt(x^2+y^2); 
      fixed = [fixed; r]; 
      gvals = [gvals; normal(2)*exp(omega*y*sqrt(-1))];  
  end  
  if (abs(x)>4.999 | abs(y)>4.999) % pml
      fixed = [fixed; r];
      gvals = [gvals; 0]; 
  end 
end
free=setdiff([1:ne],fixed); 
b=b(free)-A(free,fixed)*gvals; 
A=A(free,free); 
xi=zeros(ne,1); 
xi(fixed)=gvals;
xi(free)=A\b; 


