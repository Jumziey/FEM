function [v,b,c] = HatCoefficients(xc,yc,ex,ey)
V=[ones(3,1) xc yc];
A=V\eye(3,3);
a=A(1,:); b=A(2,:); c=A(3,:);
v=a+b*ex+c*ey;