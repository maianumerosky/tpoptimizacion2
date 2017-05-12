function H = hessiano(f,x)
    n = length(x);
    H = zeros(n);
    for i=1:n
        for j=1:n
            f_i = @(y)(dxi(f,y,i));
            H(i,j) = dxi(f_i,x,j);
        end
    end