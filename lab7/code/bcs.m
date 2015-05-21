function [R,mask,g] = bcs(p,e)
	np=size(p,2);
	R=sparse(np,np);
	mask=ones(np,1);
	g=zeros(np,1);
	bdrynodes=unique(union(e(1,:),e(2,:)));
	for i=1:length(bdrynodes)
			node=bdrynodes(i);
			x=p(1,node); y=p(2,node);
		if x<0.001
			g(node)=2.5*0.25*y*(4-y); % inflow velocity
		end
		if (x>19.999 & y>0.001 & y<3.999)
			R(node,node)=1.e+6; % outflow, p=0
		else
			mask(node)=0; % u=0
		end
	end
end
