function MaxwellVisualizer(p,e,t,xi,ne,nt,signs,dummy)
  
nt=size(t,2);    

E = zeros(2,nt);
H = zeros(1,nt);
for i=1:nt
    nodes = t(1:3,i);
    x = p(1,nodes); y = p(2,nodes); 
    edges = e(i,:); 
    xiK = xi(edges);
    len = zeros(3,1);
    len(1)=sqrt((x(3)-x(2))^2+(y(3)-y(2))^2);
    len(2)=sqrt((x(1)-x(3))^2+(y(1)-y(3))^2);
    len(3)=sqrt((x(2)-x(1))^2+(y(2)-y(1))^2); 
    len = len.*signs(:,i);
    [area,b,c] = HatGradients(x,y);
    S_1 = len(1)*[b(3)-b(2); c(3)-c(2)]/3;
    S_2 = len(2)*[b(1)-b(3); c(1)-c(3)]/3;
    S_3 = len(3)*[b(2)-b(1); c(2)-c(1)]/3; 
    rot_1 = len(1)/area; 
    rot_2 = len(2)/area; 
    rot_3 = len(3)/area;
    E(:,i) = xiK(1)*S_1 + xiK(2)*S_2 + xiK(3)*S_3;
    H(i)   = xiK(1)*rot_1 + xiK(2)*rot_2 + xiK(3)*rot_3;
end 
E=real(E);
H=real(H);

figure(5)
handle=pdeplot(p,dummy,t,'flowdata',E),axis equal,xlabel('x_1'),ylabel('x_2');
hold on, 
hh=pdegplot('circleg')
set(hh,'Color','k')
get(handle)
set(handle,'LineWidth',2,'AutoScaleFactor',2),axis tight
figure(2)
un=pdeprtni(p,t,E(1,:));
pdeplot(p,[],t,'xydata',un,'xystyle','off','contour','on','levels',10,'colorbar','on');
axis equal,view(2),xlabel('x_1'),ylabel('x_2'),axis tight
hold on, %pdegplot(dl)
hh=pdegplot('circleg')
set(hh,'Color','k')
max(abs(un))
min(abs(un))
figure(3)
un=pdeprtni(p,t,E(2,:));
pdeplot(p,[],t,'xydata',un,'xystyle','off','contour','on','levels',10,'colorbar','on');
axis equal,view(2),xlabel('x_1'),ylabel('x_2'),axis tight
hold on, %pdegplot(dl)
hh=pdegplot('circleg')
set(hh,'Color','k')
figure(4)
un=pdeprtni(p,t,H);
pdeplot(p,[],t,'xydata',un,'xystyle','off','contour','on','levels',10,'colorbar','on');
axis equal,view(2),xlabel('x_1'),ylabel('x_2'),axis tight
hold on, %pdegplot(dl)
hh=pdegplot('circleg')
set(hh,'Color','k')
