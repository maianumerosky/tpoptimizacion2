
f = @rastrigin;
x = [-2.5;3.5];
minimo = fminsearch(f,x);
[y t n yy] = metodogradiente(f,x,'Paso','1');
[y_ t_ n_ yy_] = metodogradiente(f,x,'Paso','2');
[y__ t__ n__ yy__] = metodogradiente(f,x,'Paso','3');
[y___ t___ n___ yy___] = metodogradiente(f,x,'Paso','4');


[d lb ub argmi min] = feval(f);
e_x = linspace(lb(1),ub(1),500);
e_y = linspace(lb(2),ub(2),500);
e_z = zeros(length(e_y),length(e_x));
for i = 1:length(e_x)
    for j = 1:length(e_y)
        e_z(i, j) = f([e_x(i), e_y(j)]);
    end
end
contour(e_x,e_y,e_z)
%mesh(e_x,e_y,e_z)
%saveas(gcf, 'zettl', 'jpg')
hold on
plot3(yy(1,:),yy(2,:),f(yy),'y.-','MarkerSize',10)
plot3(yy_(1,:),yy_(2,:),f(yy_),'ro-','MarkerSize',10)
plot3(yy__(1,:),yy__(2,:),f(yy__),'gv-','MarkerSize',10)
plot3(yy___(1,:),yy___(2,:),f(yy___),'b<-','MarkerSize',10)


%ezimage(f)
% legend off
% view(-15,40)
% dif_minimos = [y-minimo y_-minimo y__-minimo]