function [y varargout] = gradienteconj(f,x,varargin)
    Cuad = opcion('Cuad',varargin,0);
    intermedios = [x];
    
    if Cuad == 1
        %% Metodo Gradiente Cuadraticas
        ind = strmatch('Cuad',varargin);
        Q = eval(varargin{ind+2});
        b = eval(varargin{ind+3});

        n = length(x);
        d = b - Q*x;
        g = Q*x-b;
        
        tic
        for i=0:n-1
            if d ~= 0
                alpha = (-g'*d)/(d'*Q*d);
                x = x + alpha*d;
                g = Q*x-b;
                beta = (g'*Q*d)/(d'*Q*d);
                d = -g+beta*d;
                intermedios = [intermedios x];
            end
        end
        varargout{1} = toc;
        varargout{2} = intermedios;
    
    %% Metodo Gradiente General
    else
        n = length(x);
        MaxNumIter = opcion('MaxNumIter',varargin,100);
        tolIter = opcion('tolIter',varargin,10^(-4));
        tolGrad = opcion('tolGrad',varargin,10^(-4));
        Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
        Hess = opcion('Hess',varargin,@(x) hessiano(f,x));
        
        e = inf;
        i = 1;
        tic
        while norm(Grad(x))>tolGrad && i<=MaxNumIter && e>tolIter
            if Grad(x) ~= 0
                g = (Grad(x))'; 
                d = -g;

                for i=0:n-2
                    hess = Hess(x); 
                    alpha = (-g'*d)/(d'*hess*d);
                    e = norm(alpha*d);
                    x = x + alpha*d;
                    g = (Grad(x))';
                    beta = (g'*hess*d)/(d'*hess*d);
                    d = -g+beta*d;
                    intermedios = [intermedios x];
                end
            end
            i = i + 1;
        end
        varargout{1} = toc;
        varargout{2} = i;
        varargout{3} = intermedios;
    end
    
    y = x;