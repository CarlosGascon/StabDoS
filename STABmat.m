function [MatStabP, MatStabH, MatStabG] = STABmat(avect, Mvect, Target)
% Description: This function calculates the stability grid using the  AMD
% Hill Stability criteria.

% Input: - avect: Array containing semi-major axis values in [AU]
%        - Mvect: Array containing mass values in [Mjup]
%        - Target: Struct containing Target information

% Output: - MatStabP: Matrix containing stability probability according to
%                     Petrovich's criterion for grid a defined by avect and
%                     mvect
%         - MatStabH: Matrix containing stability probability according to
%                     the Hill AMD criterion for a grid defined by avect
%                     and mvect

%         - MatStabG: Matrix containing stability probability according to
%                     Giuppone's criterion for a grid defined by avect and
%                     mvect

% References: 

% - [1] Giuppone, C., Morais, M., and Correia, A. (2013). A semi-empirical stability criterion for real planetary systems
%       with eccentric orbits. Monthly Notices of the Royal Astronomical Society, 436(4):3547{3556.

% - [2] Petit, A. C., Laskar, J., and Boue, G. (2018). Hill stability in the amd framework. Astronomy & Astrophysics,
%       617:A93.

% - [3] Petrovich, C. (2015). The stability and fates of hierarchical two-planets systems. The Astrophysical Journal,
%       808(2):120.

if isnan(Target(1).I) % Check if System's inclination is known
    Imin = 0;         % Minimum System's inclination
    Imax = pi;        % Maximum System's inclination
else
    Imin = Target(1).I;         % Asign known value  
    Imax = Target(1).I;         % Asign same value as Imin
end

MatStabP = zeros(length(Mvect), length(avect)); % Initialize Petrovich stability matrix 
MatStabH = zeros(length(Mvect), length(avect)); % Initialize Hill stability matrix 
MatStabG = zeros(length(Mvect), length(avect)); % Initialize Giuppone stability matrix 

dnsfunP = STABfunP(Target(1).a, Target(1).pmass, Target(1).e, Target(1).smass, Imin, Imax); % Obtain Petrovich rho conditional density function
dnsfunH = STABfunH(Target(1).a, Target(1).pmass, Target(1).e, Target(1).smass, Imin, Imax); % Obtain Hill C conditional density function
dnsfunG = STABfunG(Target(1).a, Target(1).pmass, Target(1).e, Target(1).smass, Imin, Imax); % Obtain Giuppone rho conditional density function


for j = 1 : length(Mvect)        % Iterate over mass vector  
    for i = 1 : length(avect)    % Iterate over the sma vector
        if Imin == Imax          % Check if system's inclination is known
            MatStabP(j, i) = dnsfunP(Mvect(j), avect(i));   % Directly calculate probability value
            MatStabH(j, i) = dnsfunH(Mvect(j), avect(i));   % Directly calculate probability value
            MatStabG(j, i) = dnsfunG(Mvect(j), avect(i));   % Directly calculate probability value
        else
            MatStabP(j, i) = integral(@(I) dnsfunP(Mvect(j), avect(i), I), Imin, Imax, 'Reltol', 1e-5); % Integrate over the system's inclination
            MatStabH(j, i) = integral(@(I) dnsfunH(Mvect(j), avect(i), I), Imin, Imax, 'Reltol', 1e-5); % Integrate over the system's inclination
            
            if avect(i) < Target(1).a                                                                   % Check if known planet is outer
                if Target(1).pmass >= (((1 / 1.46) ^ (7 / 2)) * Target(1).smass - Mvect(j))             % Check necessary condition 
                    MatStabG(j, i) = 0;
                else
                    IminMod = asin(Target(1).pmass / (((1 / 1.46) ^ (7 / 2)) * Target(1).smass - Mvect(j)));           % Calculate Modified inclination values
                    ImaxMod = pi - IminMod;                                                                            % Calculate Modified inclination values
                    MatStabG(j, i) = integral(@(I) dnsfunG(Mvect(j), avect(i), I), IminMod , ImaxMod, 'Reltol', 1e-5); % Integrate over the system's inclination 
                end                    
            else
                MatStabG(j, i) = integral(@(I) dnsfunG(Mvect(j), avect(i), I), Imin , Imax, 'Reltol', 1e-5);            % Integrate over the system's inclination
            end
        end
    end
end



end

