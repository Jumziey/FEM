x = [0 3 2];
y = [0 1 2];

D = [4 1 0; 1 4 0; 0 0 2];

area = polyarea(x,y);
b = [y(2)-y(3); y(3)-y(1); y(1)-y(2)];
c = [x(3)-x(2); x(1)-x(3); x(2)-x(1)];
Be = [b(1)	0			b(2)		0			b(3)		0;
				0			c(1)		0		c(2)		0			c(3);
				c(1)	b(1)	c(2)	b(2)	c(3)		b(3)] /(2*area);

Ke = Be'*D*Be*area

disp('I suck at eigenvalues')
