clear all, close all
f = @(x) (1-x(2)).^2 + 100*(x(1)-x(2).^2).^2;
%grad = @(x) [200*(x(1)-x(2).^2), 2*x(2)-2-400*(x(1)-x(2).^2).*x(2)];
grad = @(x) gradiente(f,x)';
%f = @(x) (x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);
%grad = @(x) [4*(x(1)-x(2)).^3+4*x(1)-1 , -4*(x(1)-x(2)).^3+2*x(2)+2];
x = [-0.8,-1];
puntox = x(1);
puntoy = x(2);
n = 1;

X = -1:0.01:1;
[XX,YY] = meshgrid(X,X);
Z = (1-YY).^2 + 100*(XX-YY.^2).^2;
%Z = (XX-YY).^4 + 2*XX.^2+YY.^2-XX+2*YY;
surf(XX,YY,Z)
shading('INTERP')

hold on

while norm(grad(x)) > 0.001 && n < 10000
    d = -grad(x);
    phi = @(t) f(x + t*d);
    t = fminsearch(phi,0);
    x = x + t * d;
    %puntox = [puntox x(1)];
    %puntoy = [puntoy x(2)];
    plot3(x(1),x(2),f(x),'r.-','Markersize',10)
    n = n+1;
end

%plot3(puntox, puntoy,f(punto))


