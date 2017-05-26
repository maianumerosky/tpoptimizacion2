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
    MaxNumIter = opcion('MaxNumIter',varargin,1000);
    tolGrad = opcion('tolGrad',varargin,10^(-4));
    Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
    alpha0 = opcion('alpha0',varargin,10);
    eta = opcion('eta',varargin,10);

    n = 1;
    tic
    while norm(Grad(x)) > tolGrad && n < MaxNumIter
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
        x = x + t * d;
        n = n+1;
    end
    toc
    y = x;