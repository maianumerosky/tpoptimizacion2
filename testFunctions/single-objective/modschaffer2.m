function varargout = modschaffer2(X)
% modified Schaffer function, #2
%
%   MODSCHAFFER2([x1, x2]) returns the value of the 2nd Schaffer
%   function at the specified points. [x1] and [x2] may be vectors.
%   The search domain is
%
%               -100 < x_i < 100
%
%   The global minimum is 
%
%               f(x1, x2) = f(0, 0) = 0.


% Please report bugs and inquiries to: 
%
% Name       : Rody P.S. Oldenhuis
% E-mail     : oldenhuis@gmail.com    (personal)
%              oldenhuis@luxspace.lu  (professional)
% Affiliation: LuxSpace s�rl
% Licence    : GPL + anything implied by placing it on the FEX


% If you find this work useful, please consider a donation:
% https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6G3S5UYM7HJ3N


    % if no input is given, return dimensions, bounds and minimum
    if (nargin == 0)
        varargout{1} = 2;  % # dims
        varargout{2} = [-100, -100]; % LB
        varargout{3} = [+100, +100]; % UB
        varargout{4} = [0, 0]; % solution
        varargout{5} = 0; % function value at solution

    % otherwise, output function value
    else

        % keep values within the search interval
        X(X < -100) = inf;      X(X > 100) = inf;

        % split input vector X into x1, x2
        if size(X, 1) == 2
            x1 = X(1, :);        x2 = X(2, :);
        else
            x1 = X(:, 1);        x2 = X(:, 2);
        end

        % output function value
        varargout{1} = 0.5  + (sin(x1.^2 - x2.^2).^2 - 0.5) ./ (1+0.001*(x1.^2 + x2.^2)).^2;

    end
     
end