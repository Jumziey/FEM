function Ke = stiffness(x,y, mu, lambda)
	area = polyarea(x,y);
	
	b = [y(2)-y(3); y(3)-y(1); y(1)-y(2)];
	c = [x(3)-x(2); x(1)-x(3); x(2)-x(1)];
	
	D = mu*[2 0 0; 0 2 0; 0 0 1] + lambda*[1 1 0; 1 1 0; 0 0 0];
	
	Be = [b(1)	0			b(2)		0			b(3)		0;
				0			c(1)		0		c(2)		0			c(3);
				c(1)	b(1)	c(2)	b(2)	c(3)		b(3)] /(2*area);
	
	Ke = Be'*D*Be;
end
				
