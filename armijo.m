function t = armijo(f,x)

d = -grad(x)';
t = 1;
nu = 10;

while f(x + t*dk') > f(x) + t*0.2*grad(x)*d
  t = t/nu;
end

while f(x + nu*t*dk') <= f(x) + nu*t*0.2*grad(x)*d
    t = nu * t;
end