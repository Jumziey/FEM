function [A,M,Bx,By] = assemble(p,e,t)

	nt=size(t,2); np=size(p,2);
	A=sparse(np,np);
	M=zeros(np,1);
	Bx=sparse(np,np);
	By=sparse(np,np);
	
	for i=1:nt
		% element nodes, coordinates, and area
		nodes = t(1:3,i);
		x=p(1,nodes); y=p(2,nodes);
		area=polyarea(x,y);
		
		% hat function gradients
		b_=[y(2)-y(3); y(3)-y(1); y(1)-y(2)]/2/area;
		c_=[x(3)-x(2); x(1)-x(3); x(2)-x(1)]/2/area;
		
		% stiffness matrix
		A(nodes,nodes)=A(nodes,nodes)+(b_*b_'+c_*c_')*area;
		
		% lumped mass matrix (stored as a vector)
		M(nodes)=M(nodes)+[1; 1; 1]*area/3;
		
		% gradient matrices
		Bx(nodes,nodes)=Bx(nodes,nodes)+ones(3,1)*b_'*area/3;
		By(nodes,nodes)=By(nodes,nodes)+ones(3,1)*c_'*area/3;
	end
end
