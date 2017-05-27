function [y varargout] = metodogradiente(f,x,varargin)
% Configuracion de opciones: El usuario debera ingresar todas las opciones
% y sus valores en formato string. Siempre primero el nombre de la opcion y
% luego separado por una coma su valor. Es importante respetar mayusuculas
% y minusculas. No es importante el orden de las opciones.
% Ejemplo: Para ingresar una cantidad maxima de 50 iteraciones y el gradiente
% analitico. 
% f = x(1)^2 + x(2)^2
% y = metodogradiente(f,x,'Grad','@(x) [2x(1),2x(2)]','tolIter','50')
% Esto tambien es equivalente a:
% y = metodogradiente(f,x,'tolIter','50','Grad','@(x) [2x(1),2x(2)]')

%Lo referido a varargout es para obtener datos auxiliares para el tp, esto
%son los tiempos que demora el metodo, la cantidad de iteraciones, y los
%puntos intermedios que fue recorriendo hasta que finalizo.

% El usuario observando la lista siguiente, ya parte del codigo se dara
% cuenta de que opciones son modificables.

    Paso = opcion('Paso',varargin,1);
    MaxNumIter = opcion('MaxNumIter',varargin,1000);
    tolIter = opcion('tolIter',varargin,10^(-4));
    tolGrad = opcion('tolGrad',varargin,10^(-4));
    Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
    alpha0 = opcion('alpha0',varargin,10);
    eta = opcion('eta',varargin,10);

    n = 1;
    intermedios = [x];
    e = inf;
    
    tic
    while norm(Grad(x)) > tolGrad && n <= MaxNumIter && e>tolIter
        d = -Grad(x)';
        phi = @(t) f(x + t*d);
        if Paso == 1
          t = fminsearch(phi,0);
        elseif Paso == 2
          t = fminbnd(phi,0,alpha0);
        elseif Paso == 3
          t = triseccion(phi,0,alpha0);
        elseif Paso == 4;
          t = armijo(phi,x,eta,Grad);
        end
        e = norm(t*d); %Pues el error es ||x - (x+t*d)||
        x = x + t * d;
        intermedios = [intermedios x];
        n = n+1;
    end
    varargout{1} = toc;
    varargout{2} = n-1;
    varargout{3} = intermedios;
    y = x;