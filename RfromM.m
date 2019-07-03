function [Rp] = RfromM(m)
% Description: The following function estimates the planetary radius given its
% mass, using a modification of the FORECASTER best fit(Chen & Kipping 2016). 

% Input:  - m: Array of planetary masses (Jupiter Masses)

% Output: - Rp: Array of estimated planetary radius (Earth Radius)

% Examples:
% References:

Mearth = 5.9723e24;             % Earth Mass [kg]
Mjup = 1.89819 * 10^27;         % Jupiter Mass [kg]
m = m * (Mjup / Mearth);        % Convert input mass array from Jupiter masses to Earth masses

Cvec = [0.00346053, -0.06613329, 0.48091861, 1.04956612, -2.84926757]; % Modified fit C parameters
Svec = [0.279, 0.50376436, 0.22725968, 0, 0.881];                      % Modified fit S parameters
Tvec = [0, 2.04, 95.16, 317.828407, 26635.6863, Inf];                  % Modified fit mass intervals

Rp = zeros(1, length(m));               % Initialize planetary radius array
for i = 1 : length(m)                   % Iterate over the mass array
    [N, ~] = histcounts(m(i), Tvec);    % Identify Mass interval                                
    C = Cvec * N';                      % Obtain corresponding C value
    S = Svec * N';                      % Obtain corresponding S value
    Rp(i) = (10^(C + log10(m(i)) * S)); % Obtain output planetary radius
end

end

