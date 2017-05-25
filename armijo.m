function t = armijo(f,x,eta)

d = -grad(x)';
t = 1;

while f(x + t*dk') > f(x) + t*0.2*grad(x)*d
  t = t/eta;
end

while f(x + eta*t*dk') <= f(x) + eta*t*0.2*grad(x)*d
    t = eta * t;
end