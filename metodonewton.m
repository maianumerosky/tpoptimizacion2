function [y varargout] = metodonewton(f,x, varargin)

    MaxNumIter = opcion('MaxNumIter',varargin,1000);
    Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
    Hess = opcion('Hess',varargin,@(x) hessiano(f,x));
    tolGrad = opcion('tolGrad',varargin,10^(-4));

    n = 1;
    H = Hess(x);
    
    intermedios = [x];
    
    tic
    while norm(Grad(x)) > tolGrad && n <= MaxNumIter
        try 
            L = chol(H);
            U = L\(-Grad(x)');
            d = L'\U;
            phi = @(t) f(x + t*d);
            t = fminsearch(phi,0);
            x = x + t*d;
            intermedios = [intermedios x];
            n = n + 1;
            H = Hess(x);
        catch
            H = H + eye(length(x));
        end
    end
    varargout{1} = toc;
    varargout{2} = n-1;
    varargout{3} = intermedios;
    y = x;

