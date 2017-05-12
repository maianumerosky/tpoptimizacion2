function y = gradiente(f,x)
    n = length(x);
    y = [];
    for i = 1:n
        y = [y; dxi(f,x,i)];
    end
    