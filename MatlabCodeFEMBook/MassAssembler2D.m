function M = MassAssembler2D(p,t)
np = size(p,2); % number of nodes
nt = size(t,2); % number of elements
M = sparse(np,np); % allocate mass matrix
for K = 1:nt % loop over elements
    loc2glb = t(1:3,K); % local-to-global map
    x = p(1,loc2glb); % node x-coordinates
    y = p(2,loc2glb); %             y
    area = polyarea(x,y); % triangle area
    MK = [2 1 1;
          1 2 1;
          1 1 2]/12*area; % element mass matrix
    M(loc2glb,loc2glb) = M(loc2glb,loc2glb) ...
        + MK; % add element masses to M
end

