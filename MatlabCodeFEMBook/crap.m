clear all
syms x y real
u=x*(1-x)^2*(exp(10*x^2)-1)*y*(1-y)^2*(exp(10*y^2)-1)

ux=diff(u,x);
uy=diff(u,y);
uxx=diff(ux,x);
uyy=diff(uy,y);
g=-(uxx+uyy);

syms a b c d e f real

g=subs(g,exp(10*x^2)-1,a)
g=subs(g,exp(10*y^2)-1,b)
g=subs(g,exp(10*x^2),c)
g=subs(g,exp(10*y^2),d)
g=subs(g,x-1,e)
g=subs(g,y-1,f)

g=expand(g)