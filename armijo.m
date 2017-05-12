clear all, close all
f = @(x) (1-x(2)).^2 + 100*(x(1)-x(2).^2).^2;
grad = @(x) [200*(x(1)-x(2).^2), 2*x(2)-2-400*(x(1)-x(2).^2).*x(2)];
d = [cos(pi/10) -sin(pi/10);sin(pi/10) cos(pi/10)];
x = [0,0];
dk = d*(-grad(x))';
lambda = 1;
n = 1;

while n < 1000000 && norm(grad(x))>0.001
    if f(x + lambda*dk') <= f(x) + lambda*0.2*grad(x)*dk
        x = x + lambda*dk';
        dk = d*(-grad(x))';
    else
        lambda = 0.3*lambda;
    end
    n = n+1;

end
