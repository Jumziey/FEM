syms x y;
c = 100;
uSym = -exp(-c*(x.^2+y.^2))
fSym = laplace(uSym,x,y)
subs(fSym,x,[1 2 3])
double(subs(fSym,y,[2 3 1]))
