function C = ConvectionAssembler2D(p,t,bx,by)
np=size(p,2);
nt=size(t,2);
C=sparse(np,np);
for i=1:nt
    loc2glb=t(1:3,i);
    x=p(1,loc2glb);
    y=p(2,loc2glb);
    [area,b,c]=HatGradients(x,y);
    bxmid=mean(bx(loc2glb));
    bymid=mean(by(loc2glb));
    CK=ones(3,1)*(bxmid*b+bymid*c)'*area/3;
    C(loc2glb,loc2glb)=C(loc2glb,loc2glb)+CK;
end
