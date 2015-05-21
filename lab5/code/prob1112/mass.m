function Me = mass(x,y,rho);
	area = polyarea(x,y);
	Me = rho*[2 0 1 0 1 0;
						0 2 0 1 0 1;
						1 0 2 0 1 0;
						0 1 0 2 0 1;
						1 0 1 0 2 0;
						0 1 0 1 0 2]*area/12;
end
