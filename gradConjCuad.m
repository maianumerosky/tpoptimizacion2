% %% Metodo Gradiente Cuadraticas
% Q = [1 0;0 10];
% b = [0;0];
% 
% x = [8;20];
% n = length(x);
% d = b - Q*x;
% g = Q*x-b;
% 
% for i=0:n-1
%     alpha = (-g'*d)/(d'*Q*d);
%     x = x + alpha*d;
%     g = Q*x-b;
%     beta = (g'*Q*d)/(d'*Q*d);
%     d = -g+beta*d;
% end


%% Metodo Gradiente General
f = @(x) 0.5*x(1)^2+5*x(2)^2;
x = [8;20];
n = length(x);
for i=1:10
    g = (gradiente(f,x))'; %x columna devuelve columna
    d = -g;

    for i=0:n-2
        hess = hessiano(f,x); 
        alpha = (-g'*d)/(d'*hess*d);
        x = x + alpha*d;
        g = (gradiente(f,x))';
        beta = (g'*hess*d)/(d'*hess*d);
        d = -g+beta*d;
    end
end
