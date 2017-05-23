function y = newton(f,x, varargin)

[a,b] = ismember('MaxNumIter',varargin)
if a == 1
  MaxNumIter = str2num(varargin{b+1});
else
  MaxNumIter = 1000;
end

[a,b] = ismember('tolGrad',varargin)
if a == 1
  tolGrad = str2num(varargin{b+1});
else
  tolGrad = 10^(-4);
end

[a,b] = ismember('tolIter',varargin)
if a == 1
  tolIter = str2num(varargin{b+1});
else
  tolIter = 10^(-4);
end

y = x;
E = 1;
n = 0;
while (E > 0.0001 && n <= 1000)
    y_nueva = y - inv(hessiano(f,y))*gradiente(f,y)';
    n = n + 1;
    E = norm(y_nueva-y);
    y = y_nueva;
end
n