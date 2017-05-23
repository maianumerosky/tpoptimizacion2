function x = metodogradiente(f,x,varargin)

[a,b] = ismember('Paso',varargin);
if a == 1
  Paso = str2num(varargin{b+1});
else
  Paso = 1;
end

[a,b] = ismember('MaxNumIter',varargin);
if a == 1
  MaxNumIter = str2num(varargin{b+1});
else
  MaxNumIter = 1000;
end

[a,b] = ismember('tolGrad',varargin);
if a == 1
  tolGrad = str2num(varargin{b+1});
else
  tolGrad = 10^(-4);
end

[a,b] = ismember('tolIter',varargin);
if a == 1
  tolIter = str2num(varargin{b+1});
else
  tolIter = 10^(-4);
end

[a,b] = ismember('Grad',varargin);
if a == 1
  Grad = eval(varargin{b+1});
else
  Grad = gradiente(f,x);
end

[a,b] = ismember('Hess',varargin);
if a == 1
  Hess = eval(varargin{b+1});
else
  Hess = hessiano(f,x);
end

[a,b] = ismember('alpha0',varargin);
if a == 1
  alpha0 = str2num(varargin{b+1});
else
  alpha0 = 10;
end

[a,b] = ismember('nu',varargin);
if a == 1
  nu = str2num(varargin{b+1});
else
  nu = 10;
end

f = @(x) (1-x(2)).^2 + 100*(x(1)-x(2).^2).^2;
%grad = @(x) [200*(x(1)-x(2).^2), 2*x(2)-2-400*(x(1)-x(2).^2).*x(2)];
grad = @(x) gradiente(f,x);
%f = @(x) (x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);

%grad = @(x) [4*(x(1)-x(2)).^3+4*x(1)-1 , -4*(x(1)-x(2)).^3+2*x(2)+2];
x = [0;0];
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

while norm(grad(x)) > 0.001 && n < 1000
    d = -grad(x)';
    phi = @(t) f(x + t*d);
    if Paso == 1
      t = fminsearch(phi,0);
    elseif Paso == 2
      t = fminbnd(phi,0,alpha0);
    elseif Paso == 3
      t = triseccion(f,0,alpha0);
    elseif Paso == 4;
      t = armijo(phi,x,nu);
    end
    x = x + t * d;
    %puntox = [puntox x(1)];
    %puntoy = [puntoy x(2)];
    plot3(x(1),x(2),f(x),'r.-','Markersize',10)
    n = n+1;
end

%plot3(puntox, puntoy,f(punto))
