function y = newton(f,x, varargin)

MaxNumIter = opcion('MaxNumIter',varargin,1000);
tolIter = opcion('tolIter',varargin,10^(-4));
Grad = opcion('Grad',varargin,@(x) gradiente(f,x));
Hess = opcion('Hess',varargin,@(x) hessiano(f,x));


y = x;
E = 1;
n = 0;
while (E > tolIter && n <= MaxNumIter)
    y_nueva = y - inv(Hess(y))*(Grad(y))';
    n = n + 1;
    E = norm(y_nueva-y);
    y = y_nueva;
end
