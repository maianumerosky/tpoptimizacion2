function y = metodogradiente(f,x,varargin)
% Configuracion de opciones: El usuario debera ingresar todas las opciones
% y sus valores en formato string. Siempre primero el nombre de la opcion y
% luego separado por una coma su valor. Es importante respetar mayusuculas
% y mietasculas. No es importante el orden de las opciones.
% Ejemplo: Para ingresar una cantidad maxima de 50 iteraciones y el gradiente
% analitico. 
% f = x(1)^2 + x(2)^2
% y = metodogradiente(f,x,'Grad','@(x) [2x(1),2x(2)]','tolIter','50')
% Esto tambien es equivalente a:
% y = metodogradiente(f,x,'tolIter','50','Grad','@(x) [2x(1),2x(2)]')

% El usuario observando la lista siguiente, ya parte del codigo se dara
% cuenta de que opciones son modificables.

    Paso = opcion('Paso',varargin,1);
    MaxetamIter = opcion('MaxetamIter',varargin,1000);
    tolGrad = opcion('tolGrad',varargin,10^(-4));
    tolIter = opcion('tolIter',varargin,10^(-4));
    Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
    alpha0 = opcion('alpha0',varargin,10);
    eta = opcion('eta',varargin,10);

%f = @(x) (1-x(2)).^2 + 100*(x(1)-x(2).^2).^2;
%grad = @(x) [200*(x(1)-x(2).^2), 2*x(2)-2-400*(x(1)-x(2).^2).*x(2)];
%grad = @(x) gradiente(f,x);
%f = @(x) (x(1)-x(2)).^4+2*x(1).^2+x(2).^2-x(1)+2*x(2);

%grad = @(x) [4*(x(1)-x(2)).^3+4*x(1)-1 , -4*(x(1)-x(2)).^3+2*x(2)+2];
% x = [0;0];
% puntox = x(1);
% puntoy = x(2);
% n = 1;
% 
% X = -1:0.01:1;
% [XX,YY] = meshgrid(X,X);
% Z = (1-YY).^2 + 100*(XX-YY.^2).^2;
% %Z = (XX-YY).^4 + 2*XX.^2+YY.^2-XX+2*YY;
% surf(XX,YY,Z)
% shading('INTERP')
% 
% hold on
    n = 1;
    while norm(Grad(x)) > tolGrad && n < MaxetamIter
        d = -grad(x)';
        phi = @(t) f(x + t*d);
        if Paso == 1
          t = fminsearch(phi,0);
        elseif Paso == 2
          t = fminbnd(phi,0,alpha0);
        elseif Paso == 3
          t = triseccion(f,0,alpha0);
        elseif Paso == 4;
          t = armijo(phi,x,eta);
        end
        x = x + t * d;
        n = n+1;
    end
    
    y = x;