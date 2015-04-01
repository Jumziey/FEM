function neighbors = Tri2Tri(p,t)
nno=size(p,2);
nel=size(t,2);
n2e=sparse(nno,nel);
for e=1:nel
  n2e(t(1:3,e),e)=ones(3,1);
end
e2e=n2e'*n2e;
neighbors=-ones(nel,3);
for e=1:nel
  nodes=t(1:3,e);
  nbrs=find(e2e(e,:)==2);
  for edge=1:3
    switch edge
     case 1, n1=nodes(2); n2=nodes(3);                            
     case 2, n1=nodes(1); n2=nodes(3);
     case 3, n1=nodes(1); n2=nodes(2);
    end
    for j=1:length(nbrs)
      nbrnodes=t(1:3,nbrs(j));
      if (ismember(n1,nbrnodes) & ...
          ismember(n2,nbrnodes))
        neighbors(e,edge)=nbrs(j);
      end
    end
  end
end
