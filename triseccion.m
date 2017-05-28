function [x,y] = triseccion(f,a,b,alpha)
    if abs(b-a)>alpha
        x1 = a+((b-a)/3);
        x2 = a+(2*(b-a)/3);
        if f(x1) < f(x2)
            [x,y] = triseccion(f,a,x2,alpha);
        elseif f(x1) > f(x2)
            [x,y] = triseccion(f,x1,b,alpha);
        else
            [x,y] = triseccion(f,x1,x2,alpha);
        end
    else
        x = a;
        y = b;
        return
    end
end

