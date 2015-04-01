function [area,Sx,Sy] = CRGradients(x,y)
[area,b,c]=HatGradients(x,y);
Sx=[-b(1)+b(2)+b(3); b(1)-b(2)+b(3); b(1)+b(2)-b(3)];
Sy=[-c(1)+c(2)+c(3); c(1)-c(2)+c(3); c(1)+c(2)-c(3)];
