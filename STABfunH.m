function [Intdnsfun] = STABfunH(a1, m1, e1, ms, Imin, Imax)
% Description: The following function returns the conditional probability
% for the Hill AMD stability criteria as function of the test planet's 
% semi-major axis and mass, given the main orbital
% elements of the known exoplanet. 

% Input: - Orbital Elements: Known semimajor axis (a1) in [AU], planet
%          mass (m1) in [Mjup], eccentricity (e1) and star mass (ms) in 
%          [Mjup]

%        - Imin & Imax: Range of values for system's inclination

% Output: - dnsfun: conditional probability function handle

% References:

% - [1] Petit, A. C., Laskar, J., and Boue, G. (2018). Hill stability in the amd framework. Astronomy & Astrophysics,
%       617:A93.

G = 2.8247664e-07 * (365.2422 ^ 2);   % Gravitational constant [AU^3 / (JupMass * years^2)]
mu = G * ms;                           % System's gravitational parameter
sig = 0.1795;                            % Rayleigh distribution parameter
  
K = @(m1) (1 - sqrt(1 - e1 .^ 2)) .* m1 .* sqrt(mu .* a1); % Known planet's angular momentum deficit contribution

Clow = @(m1) K(m1);                                    % Minimum C value and lower integration limit
Cmax = @(m, m1, a) K(m1) + (m .* sqrt(mu .* a));       % Maximum C value

eps = @(m, m1) (m + m1) ./ (ms);                       % Planets to star mass ratio

Cc = @(gam, alf, m, m1) gam .* sqrt(alf) + 1 - ((1 + gam) .^ (3 ./ 2)) .* ...                  % Critical Hill stability AMD
     sqrt((alf ./ (gam + alf)) .* (1 + (3.^(4 ./ 3) .* eps(m, m1).^(2 / 3) .* gam) ...
     ./ (1 + gam).^2));
 
Cupaux = @(m, m1, a) Cc(m ./ m1, a ./ a1, m, m1) .* (m1 .* sqrt(mu .* a1)) .* (a <= a1) + ...  % Upper integration limit when the known planet is outer
                     Cc(m1 ./ m, a1 ./ a, m, m1) .* (m .* sqrt(mu .* a)) .* (a > a1);          % Upper integration limit when the known planet is inner

Cup = @(m, m1, a) Clow(m1) .* (Cupaux(m, m1, a) <= Clow(m1)) + ...                             % Upper limit adjustment to the range of values of C
                  Cmax(m, m1, a) .* (Cmax(m, m1, a) <= Cupaux(m, m1, a)) + ...
                  Cupaux(m, m1, a) .* (Clow(m1) < Cupaux(m, m1, a)) .* (Cupaux(m, m1, a) < Cmax(m, m1, a));
                      
auxfun = @(m, m1, a, C) (m .* sqrt(mu .* a) - C + K(m1)) ./ (m .* sqrt(mu .* a));  % Auxiliary function for integral function

intfun = @(m, m1, a, C) exp((auxfun(m, m1, a, C).^2 - 1) ./ (2 .* (sig .^ 2)));    % Integral analytic solution

Cfun = @(m, m1, a) (intfun(m, m1, a, Clow(m1)) - intfun(m, m1, a, Cup(m, m1, a))); % Evaluation at the lower and upper limits of integration

if Imin == Imax                                                % Check if inclination is known
   Intdnsfun =  @(m, a) Cfun(m, m1, a);                        % Return integral solution as a function handle
else  
   fI = @(I) sin(I) ./ (cos(Imin) - cos(Imax));                % System's inclination sinusoidal pdf
   Intdnsfun =  @(m, a, I) Cfun(m, m1 ./ sin(I), a) .* fI(I);  % Return integral solution as a function handle
end

end
