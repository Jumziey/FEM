function rK = EdgeResiduals(p,t,E,nu,U,V)
nt=size(t,2);
rK=zeros(nt,1); % allocate edge residuals
nbrs=Tri2Tri(p,t); % get element neighbours
[mu,lambda]=Enu2Lame(E,nu);
[ux,uy]=pdegrad(p,t,U); % gradient of U
[vx,vy]=pdegrad(p,t,V);
for i=1:nt
    nodes=t(1:3,i);
    x=p(1,nodes); y=p(2,nodes);
    r=0; % sum of edge residuals sqrt(h)|0.5[n.sigma]|_dK
    [area,ds,nx,ny]=Triutils(x,y);
    h=max(ds);
    for j=1:3 % loop over element edges
        n=nbrs(i,j); % element neighbour
        if n<0 % no neighbour
            continue; % don't compute on domain boundary!
                      % should compute sqrt(h)|g_N-n.sigma|_dK
        end
        Sp=Stress(mu,lambda,ux,uy,vx,vy,i); % stress on element i
        Sm=Stress(mu,lambda,ux,uy,vx,vy,n); % stress on neighbour
        jump=0.5*(Sm-Sp)*[nx(j); ny(j)]; % stress jump
        r=r+dot(jump,jump)*ds(j);
    end
    rK(i)=sqrt(h)*sqrt(r);
end
