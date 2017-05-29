clear all, close(figure(1))

%Rosenbruck
f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
% gf = @(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))];
x = [-2;2];
% x = [-10;0];


% f = @himmelblau;
% x = [0;0];
% x = [4.5;4.5];

% f = @griewank;
% x = [60;60];
% x = [70;40];

% f = @rastrigin;
% gf = @(x) [2*x(1)+20*pi*sin(2*pi*x(1)),2*x(2)+20*pi*sin(2*pi*x(2))];
% x = [-2.5;3];
% x = [-2.5;3.5];
%x = [-2.5;2];
% x = [-1.5;0];
% x = [-1.75;-0.75];

%minimo = fminsearch(f,x);
%%
% [y t n yy] = metodogradiente(f,x,'Paso','1','tolIter','-1','Grad','@(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))]');
% [y_ t_ n_ yy_] = metodogradiente(f,x,'Paso','2','tolIter','-1','Grad','@(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))]','alpha0','.05');
% [y__ t__ n__ yy__] = metodogradiente(f,x,'Paso','3','tolIter','-1','Grad','@(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))]','alpha','.001','alpha0','0.01');
% [y___ t___ n___ yy___] = metodogradiente(f,x,'Paso','4','tolIter','-1','Grad','@(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))]','eta','10');

%%
% [y t n yy] = gradienteconj(f,x);
% [y t n yy] = gradienteconj(f,x,'Grad','@(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))]');
% [y t n yy] = gradienteconj(f,x,'Grad','@(x) [2*x(1)+20*pi*sin(2*pi*x(1)),2*x(2)+20*pi*sin(2*pi*x(2))]');

%%
% [y t n yy] = metodonewton(f,x);
[y t n yy] = metodonewton(f,x,'Grad','@(x) [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)), 200*(x(2)-x(1))]','MaxNumIter','100000');

%%
% [d lb ub argmi min] = feval(f);
% e_x = linspace(lb(1),ub(1),500);
% e_y = linspace(lb(2),ub(2),500);

e_x = linspace(-2.2,2,500);
e_y = linspace(-.5,3,500);

e_z = zeros(length(e_y),length(e_x));
for i = 1:length(e_x)
    for j = 1:length(e_y)
        e_z(i, j) = f([e_x(i), e_y(j)]);
    end
end

contour(e_x,e_y,e_z,30)
mesh(e_x,e_y,e_z)
%saveas(gcf, 'zettl', 'jpg')

hold on

% plot3(yy(1,:),yy(2,:),f(yy),'y.-','MarkerSize',10)
% plot3(yy_(1,:),yy_(2,:),f(yy_),'ro-','MarkerSize',10)
% plot3(yy__(1,:),yy__(2,:),f(yy__),'gv-','MarkerSize',10)
% plot3(yy___(1,:),yy___(2,:),f(yy___),'b<-','MarkerSize',10)

%%
fyy = [];
for j = 1:length(yy)
    fyy = [fyy f(yy(:,j))];
end
% fyy_ = [];
% for j = 1:length(yy_)
%     fyy_ = [fyy_ f(yy_(:,j))];
% end
% fyy__ = [];
% for j = 1:length(yy__)
%     fyy__ = [fyy__ f(yy__(:,j))];
% end
% fyy___ = [];
% for j = 1:length(yy___)
%     fyy___ = [fyy___ f(yy___(:,j))];
% end
% 
plot3(yy(1,:),yy(2,:),fyy,'r.-','MarkerSize',15)
% plot3(yy_(1,:),yy_(2,:),fyy_,'ro-','MarkerSize',5)
% plot3(yy__(1,:),yy__(2,:),fyy__,'gv-','MarkerSize',5)
% plot3(yy___(1,:),yy___(2,:),fyy___,'b<-','MarkerSize',5)


%%
% plot3(yy(1,:),yy(2,:),f(yy),'y.-','MarkerSize',10,'LineWidth',5)
% plot3(yy(1,:),yy(2,:),f(yy),'y.-','MarkerSize',10)

% plot3(yy(1,:),yy(2,:),f(yy),'y.-','MarkerSize',10)

% legend('C. Nivel','Exacta','Acotada','Trisección','Armijo','Location','NorthWest')
% legend('C. Nivel','Exacta','Acotada','Trisección','Armijo')
% legend('C.Nivel','Exacta','Acotada','Trisección','Armijo','Location','SouthEast')
% legend('C. Nivel','Grad. Conjugado')
% legend('C. Nivel','Grad. Conjugado','Location','NorthWest')
legend('C. Nivel','Metodo Newton Búsqueda Lineal')
% legend('C. Nivel','Metodo Newton Búsqueda Lineal','Location','NorthWest')
colorbar

%ezimage(f)
% legend off
% view(-15,40)
% dif_minimos = [y-minimo y_-minimo y__-minimo]