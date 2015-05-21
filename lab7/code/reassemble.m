function C = reassemble(p,e,t,xi,eta)
	nt=size(t,2); np=size(p,2);
	C=sparse(np,np);
	for i=1:nt
		nodes=t(1:3,i);
		x=p(1,nodes); y=p(2,nodes);
		% compute the mean velocity on the element
		u=mean( xi(nodes));
		v=mean(eta(nodes));
		area=polyarea(x,y);
		b_=[y(2)-y(3); y(3)-y(1); y(1)-y(2)]/2/area;
		c_=[x(3)-x(2); x(1)-x(3); x(2)-x(1)]/2/area;
		C(nodes,nodes)=C(nodes,nodes)+ones(3,1)*(u*b_'+v*c_')*area/3;
	end
end
