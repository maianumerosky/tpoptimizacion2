function y = metodonewton(f,x, varargin)

MaxNumIter = opcion('MaxNumIter',varargin,1000);
Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
Hess = opcion('Hess',varargin,@(x) hessiano(f,x));
tolGrad = opcion('tolGrad',varargin,10^(-4));

n = 1;
while norm(Grad(x)) > tolGrad && n <= MaxNumIter
    try L = chol(Hess(x));
        U = L\(-Grad(x));
        d = L'\U;
        phi = @(t) f(x + t*d);
        t = armijo(phi,x,10);
        x = x + t*d;
        n = n + 1;
    catch
        eps = 1;
        Hess = @(x) Hess(x) + eye(length(x));
    end
    
end

y = x;