function t = armijo(f,x,nu)

d = -grad(x)';
t = 1;

while f(x + t*dk') > f(x) + t*0.2*grad(x)*d
  t = t/nu;
end

while f(x + nu*t*dk') <= f(x) + nu*t*0.2*grad(x)*d
    t = nu * t;
end