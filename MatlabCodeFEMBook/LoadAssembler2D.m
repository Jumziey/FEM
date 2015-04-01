function b = LoadAssembler2D(p,t,f)
np = size(p,2);
nt = size(t,2);
b = zeros(np,1);
for K = 1:nt
  loc2glb = t(1:3,K);
  x = p(1,loc2glb);
  y = p(2,loc2glb);
  area = polyarea(x,y);
  bK = [f(x(1),y(1));
        f(x(2),y(2));
        f(x(3),y(3))]/3*area; % element load vector
  b(loc2glb) = b(loc2glb) ...
    + bK; % add element loads to b
end
