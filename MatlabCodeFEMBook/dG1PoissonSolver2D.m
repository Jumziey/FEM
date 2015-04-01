function dG1PoissonSolver2D()
clear all, close all
g=Rectg(0,0,1,1); % unit square 
beta=9; % penalty parameter
alpha=-1; % SIPG parameter
h=0.0625; % mesh size
[p,e,t]=initmesh(g,'hmax',h);
neighbours=Tri2Tri(p,t); % element neighbours
force = inline('2*pi^2*sin(pi*x)*sin(pi*y)','x','y');
[A,B]=dG1CellAssembler2D(p,t,force);
[P,S]=dG1EdgeAssembler2D(p,t,neighbours);
U=(A-S+alpha*S'+beta/h*P)\B;
% - visualization ---
nt=size(t,2);
X=zeros(3*nt,1); Y=zeros(3*nt,1);
i=t(1,:); j=t(2,:); k=t(3,:);
X(1:3:end)=p(1,i); X(2:3:end)=p(1,j); X(3:3:end)=p(1,k);
Y(1:3:end)=p(2,i); Y(2:3:end)=p(2,j); Y(3:3:end)=p(2,k);
trisurf(reshape([1:3*nt],3,nt)',X,Y,U)
xlabel('x_1'), ylabel('x_2')


