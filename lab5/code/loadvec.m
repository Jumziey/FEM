function Fe = load(x,y,force)
	area = polyarea(x,y);
	f=force(mean(x),mean(y));
	Fe = (f(1)*[1 0 1 0 1 0].'+f(2)*[0 1 0 1 0 1]')*area/3;
end
