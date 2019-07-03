function [Mat] = SAG13mat(avect, Rvect)
% Description: The following function calculates a matrix of occurrence 
% rates according to the SAG13 broken power law, performing a change of 
% variables in order to work with planetary radius and semimajor axis,
% as well as introducing an orbital decay starting at smaknee. 

% Input: - avect: Array of semimajor axes in [AU]
%        - Rvect: Array of planetary radius in [Earth Radius]

% Output:- Grid: Matrix containing the occurrence rate values for a grid
%          defined by avect and Rvect

% References: 

% - [1] Garrett, D. and Savransky, D. (2018). Building better planet populations for exosims. In American Astronomical
%       Society, AAS Meeting, volume 231.

Msun = 1988.5 * 10^27;          % Sun Mass     [kg]
Mjup = 1.89819 * 10^27;         % Jupiter Mass [kg]
G = 2.8247664e-07 * (365.2422 ^ 2);   % Gravitational constant in  [AU^3 / (JupMass * years^2)]
smaknee = 10;                   % Decay starting point [AU]

Gam = [0.38, 0.73];    % Define Gamma coeficients for pdf
alf = [-0.19, -1.18];  % Define alpha coeficients for pdf
bet = [0.26, 0.59];    % Defime beta coeficients for pdf

ms = Msun / Mjup;      % Sun Mass [Mjup]
mu = G * ms ;          % Compute gravitational parameter [AU^3 / (years^2)]

% Define parametric fit function hangle
pdf = @(a, R) (R < 3.4) .* (Gam(1) .* (R .^(alf(1) - 1)) .* ((2 .* pi .* sqrt((a .^ 3) ./ mu)) .^ (bet(1) - 1)) .* (3 .* pi .* sqrt(a ./ mu)) .* exp(-(a ./ smaknee) .^3)) +...  
               (R >= 3.4).* (Gam(2) .* (R .^(alf(2) - 1)) .* ((2 .* pi .* sqrt((a .^ 3) ./ mu)) .^ (bet(2) - 1)) .* (3 .* pi .* sqrt(a ./ mu)) .* exp(-(a ./ smaknee) .^3));

Mat = zeros(length(Rvect), length(avect)); % Initialize output matrix

for i = 1 : (length(avect))
    for j = 1 : (length(Rvect))
        Mat(j, i) = pdf(avect(i), Rvect(j));
    end
end

end

