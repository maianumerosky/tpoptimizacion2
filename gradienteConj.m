function y = gradienteConj(f,x,varargin)

Cuad = opcion('Cuad',varargin,0);

if Cuad
    %% Metodo Gradiente Cuadraticas
    ind = strmatch('Cuad',varargin);
    Q = eval(varargin{ind+2});
    b = eval(varargin{ind+3});

    %x = [8;20];
    n = length(x);
    d = b - Q*x;
    g = Q*x-b;

    for i=0:n-1
        alpha = (-g'*d)/(d'*Q*d);
        x = x + alpha*d;
        g = Q*x-b;
        beta = (g'*Q*d)/(d'*Q*d);
        d = -g+beta*d;
    end


%% Metodo Gradiente General
else
    %f = @(x) 0.5*x(1)^2+5*x(2)^2;
    %x = [8;20];
    n = length(x);
    Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
    Hess = opcion('Hess',varargin,@(x) hessiano(f,x));
    for i=1:10
        g = (Grad(x))'; %x columna devuelve columna
        d = -g;

        for i=0:n-2
            hess = Hess(x); 
            alpha = (-g'*d)/(d'*hess*d);
            x = x + alpha*d;
            g = (Grad(x))';
            beta = (g'*hess*d)/(d'*hess*d);
            d = -g+beta*d;
        end
    end
end
y = x;