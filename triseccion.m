function [x,y] = triseccion(f,a,b)
    if abs(b-a)>0.001
        x1 = a+((b-a)/3);
        x2 = a+(2*(b-a)/3);
        if f(x1) < f(x2)
            [x,y] = triseccion(f,a,x2);
        elseif f(x1) > f(x2)
            [x,y] = triseccion(f,x1,b);
        else
            [x,y] = triseccion(f,x1,x2);
        end
    else
        x = a;
        y = b;
        return
    end
end

