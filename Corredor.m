
f = @bukin6;
x = [-10;0];
minimo = fminsearch(f,x);
[y t n yy] = metodogradiente(f,x);
[y_ t_ yy_] = gradienteconj(f,x);
[y__ t__ n__ yy__] = metodonewton(f,x);

ezimage(f)
hold on
plot3(yy(1,:),yy(2,:),f(yy),'y.--','MarkerSize',10)
plot3(yy_(1,:),yy_(2,:),f(yy_),'r.--','MarkerSize',10)
plot3(yy__(1,:),yy__(2,:),f(yy__),'g.--','MarkerSize',10)
legend off
view(-15,40)
dif_minimos = [y-minimo y_-minimo y__-minimo]