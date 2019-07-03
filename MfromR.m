function [m] = MfromR(Rp)
% Description: The following function estimates the planetary mass given its
% radius, using a modification of the FORECASTER best fit. 

% Input: - Rp: Array of planetary radius [Rearth]

% Output:  - m: Array of estimated planetary masses [Mjup]

% References:

% - [1] Chen, J. and Kipping, D. (2016). Probabilistic forecasting of the masses and radii of other worlds. The Astrophysical
%       Journal, 834(1):17.

Mearth = 5.9723e24;       % Earth Mass [kg]
Mjup = 1.89819 * 10^27;   % Jupiter Mass [kg]

Cvec = [0.00346053, -0.06613329, 0.48091861, -2.84926757];      % Modified fit C parameters
Svec = [0.279, 0.50376436, 0.22725968, 0.881];                  % Modified fit S parameters
Tvec = [0, 1.2298, 8.5520, 11.20898066, Inf];                   % Modified fit T parameters

m = zeros(length(Rp));                % Initialize planetary mass array
for i = 1 : length(Rp)
    [N, ~] = histcounts(Rp(i), Tvec); % Identify Mass interval                                
    C = Cvec * N';                    % Obtain corresponding C value
    S = Svec * N';                    % Obtain corresponding S value

    m(i) = (10 ^((log10(Rp(i)) - C) / S)) .* (Mearth ./ Mjup);  % Obtain planet mass and convert to Jupiter masses
end

end

