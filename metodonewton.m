function y = metodonewton(f,x, varargin)

MaxNumIter = opcion('MaxNumIter',varargin,1000);
Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
Hess = opcion('Hess',varargin,@(x) hessiano(f,x));
tolGrad = opcion('tolGrad',varargin,10^(-4));

n = 1;
H = Hess(x);
tic
while norm(Grad(x)) > tolGrad && n <= MaxNumIter
    try 
        L = chol(H);
        U = L\(-Grad(x)');
        d = L'\U;
        phi = @(t) f(x + t*d);
        %t = armijo(phi,x,10,Grad)
        t = fminsearch(phi,0);
        x = x + t*d;
        n = n + 1;
        H = Hess(x);
    catch
        H = H + eye(length(x));
    end
end
toc
y = x;
