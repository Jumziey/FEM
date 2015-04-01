function x = Richardson(A,x,b,maxit,alpha)
for k=1:maxit
    x=x+alpha*(b-A*x);
end
