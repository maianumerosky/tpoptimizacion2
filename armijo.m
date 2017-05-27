function t = armijo(f,x,eta,grad)
    d = (-1)*grad(x)';
    t = 1;
    
    while f(t) > f(0) + t*0.2*grad(x)*d
      t = t/eta;
    end

    while f(eta*t) <= f(0) + eta*t*0.2*grad(x)*d
        t = eta * t;
    end