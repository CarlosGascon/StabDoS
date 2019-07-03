function [dnsfun] = STABfunG(a1, mk, e1, ms, Imin, Imax)
% Description: The following function returns the probability density
% function for the AMD Hill Stability criteria, given the main orbital
% elements of the known exoplanet. 

% Input: - Orbital Elements: Known semimajor axis (a1) in [AU], planet
%          mass (m1) in [Mjup], eccentricity (e1) and star mass (ms) in 
%          [Mjup]
%        - Imin & Imax: Range of values for system's inclination

% Output: - dnsfun: PDF function handle

G = 2.8247664e-07 * (365.2422 ^ 2);   % Gravitational constant [AU^3 / (JupMass * years^2)]
sig = 0.18;                      % Rayleigh distribution parameter

Qk = a1 * (1 + e1);              % Known planet's apocenter
qk = a1 * (1 - e1);              % Known planet's pericenter

rup = @(a)  (qk ./ a) .* (a <= a1) + (a ./ Qk) .* (a > a1);          % Maximum r value and upper limit
rmin = @(a) (qk ./ (2 .* a)) .* (a <= a1) + 0 .* (a > a1);           % Minimum r value

eps = @(m, m1) (m + m1) ./ (ms);  
%rc = @(m, m1) 1 ./ (1 - 1.46 .* (eps(m, m1) .^ (2/7)));
%rc = @(m, m1) (1 + 1.46 .* (eps(m, m1) .^ (2/7)));
%rc = @(m, m1, a) (1 + 1.46 .* ((m1 / ms) .^ (2/7) + (m / ms) .^ (2/7))) .* (a < a1) ...
%              + (1 ./ (1 - 1.46 .* ((m1 / ms) .^ (2/7) + (m / ms) .^ (2/7)))) .* (a > a1) ;
rc = @(m, m1, a) (1 + 1.46 .* (eps(m, m1) .^ (2/7))) .* (a > a1) ...
              + (1 ./ (1 - 1.46 .* (eps(m, m1) .^ (2/7)))) .* (a <= a1) ;
rlowaux = @(m, m1, a) rc(m, m1, a);              

rlow = @(m, m1, a) rmin(a) .* (rlowaux(m, m1, a) <= rmin(a)) + ... 
                   rup(a) .* (rlowaux(m, m1, a) >= rup(a)) + ...     % Lower limit adjustment to the range of values of r
                   rlowaux(m, m1, a) .* (rlowaux(m, m1, a) < rup(a)) .* (rlowaux(m, m1, a) > rmin(a));
           
invfun = @(a, r) ((qk - a .* r) ./ (a .* r)) .* (a <= a1) + ...      % Inverse function when the known planet is outer
                 ((a - Qk .* r) ./ a) .* (a > a1) ;                  % Inverse function when the known planet is inner

intfun = @(a, r) exp(-(invfun(a, r).^2) ./ (2 .* (sig .^ 2)));       % Integral analytic solution

Cfun = @(m, m1, a) (intfun(a, rup(a)) - intfun(a, rlow(m, m1, a))); % Evaluation at the lower and upper limits of integration

if Imin == Imax                                             % Check if inclination is known
    dnsfun =  @(m, a) Cfun(m, mk, a);                        % Return integral solution as a function handle
else
   fI = @(I) sin(I) ./ (cos(Imin) - cos(Imax));             % System's inclination sinusoidal pdf
   dnsfun =  @(m, a, I) Cfun(m, mk ./ sin(I), a) .* fI(I);  % Return integral solution as a function handle
end

end
