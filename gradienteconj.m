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
    
    %% Metodo Gradiente General
    else
        n = length(x);
        MaxNumIter = opcion('MaxNumIter',varargin,100);
        Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
        Hess = opcion('Hess',varargin,@(x) hessiano(f,x));
                
        tic
        for i=1:MaxNumIter
            if Grad(x) ~= 0
                g = (Grad(x))'; 
                d = -g;

                for i=0:n-2
                    hess = Hess(x); 
                    alpha = (-g'*d)/(d'*hess*d);
                    x = x + alpha*d;
                    g = (Grad(x))';
                    beta = (g'*hess*d)/(d'*hess*d);
                    d = -g+beta*d;
                    intermedios = [intermedios x];
                end
            end
        end
        varargout{1} = toc;
    end
    
    varargout{2} = intermedios;
    y = x;