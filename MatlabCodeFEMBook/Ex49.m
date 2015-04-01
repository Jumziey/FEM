function Ex49()
g = Rectg(-2,-2*pi,2,2*pi);
[p,e,t] = initmesh(g,'hmax',0.5);
kappa = inline('1e6','x','y');
gD = inline('exp(x)*atan(y)','x','y');
gN = inline('0','x','y');
A = StiffnessAssembler2D(p,t,inline('1','x','y'));
[R,r] = RobinAssembler2D(p,e,kappa,gD,gN);
phi = (A+R)\r;
pdesurf(p,t,phi), xlabel('x'), ylabel('y')
