function t = armijo(f,x,eta)

d = (-1)*Grad(x)';
t = 1;

while f(x + t*d) > f(x) + t*0.2*Grad(x)*d
  t = t/eta;
end

while f(x + eta*t*d) <= f(x) + eta*t*0.2*Grad(x)*d
    t = eta * t;
end