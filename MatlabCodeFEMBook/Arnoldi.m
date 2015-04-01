function [Q,H] = Arnoldi(A,q,m)
n=size(A,1);
Q=zeros(n,m+1);
H=zeros(m+1,m);
Q(:,1)=q/norm(q);
for j=1:m
    z=A*Q(:,j);
    for i=1:j
        H(i,j)=dot(z,Q(:,i));
        z=z-H(i,j)*Q(:,i);
    end
    H(j+1,j)=norm(z);
    if H(j+1,j)==0, break, end
    Q(:,j+1)=z/H(j+1,j);
end
