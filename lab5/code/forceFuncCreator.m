function f = forceFuncCreator(lambda, mu)
	f = @(x,y) [ (lambda+mu)*(1-2*x)*(1-2*y);
		-2*mu*y*(1-y)-2*(lambda+2*mu)*x*(1-x) ];
end
