function [p,t,eta,zeta] = funnyFunc(geom, c11, c22, c12, c21, f1, f2)
	[p,e,t]=initmesh(geom,'hmax',0.1);
	N=size(p,2);
	% find triangle midpoints
	i=t(1,:); j=t(2,:); k=t(3,:);
	x=(p(1,i)+p(1,j)+p(1,k))/3;
	y=(p(2,i)+p(2,j)+p(2,k))/3;
	% evaluate coefficients and assemble
	[K,Mc11,Ff1]=assema(p,t,1,c11(x,y),f1(x,y));
	[K,Mc22,Ff2]=assema(p,t,1,c22(x,y),f2(x,y));
	[unused,Mc12,unused]=assema(p,t,0,c12(x,y),0);
	[unused,Mc21,unused]=assema(p,t,0,c21(x,y),0);
	A=[K+Mc11 Mc12; Mc21 K+Mc22];
	b=[Ff1; Ff2];
	% solve linear system
	xi=A\b;

	eta=xi(1:N); zeta=xi(N+1:end);
end
