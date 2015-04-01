function WingFlowSolver2D()
g = Airfoilg();
[p,e,t] = initmesh(g,'hmax',0.5);
A = StiffnessAssembler2D(p,t,inline('1','x','y'));
[R,r] = RobinAssembler2D(p,e,@Kappa1,@gD1,@gN1);
phi = (A+R)\r;
pdecont(p,t,phi)
