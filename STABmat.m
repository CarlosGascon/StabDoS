function [MatStabP, MatStabH, MatStabG] = STABmat(avect, Mvect, Target)
% Description: This function calculates the stability grid using the  AMD
% Hill Stability criteria.

% Input: - avect: Array containing sma values in [AU]
%        - Rvect: Array containing R values in Earth Radius
%        - Mvect: Array containing mass values in Mjup
%        - Target: Struct containing Target information

% Output: - MatStabP:
%         - MatStabH: 

if isnan(Target(1).I) % Check if System's inclination is known
    Imin = 0;         % Minimum System's inclination
    Imax = pi;        % Maximum System's inclination
else
    Imin = Target(1).I;         % Asign known value  
    Imax = Target(1).I;         % Asign same value as Imin
end

MatStabP = zeros(length(Mvect), length(avect)); % Petrovich stability matrix initialization
MatStabH = zeros(length(Mvect), length(avect)); % Hill stability matrix initialization
MatStabG = zeros(length(Mvect), length(avect)); % Hill stability matrix initialization

dnsfunP = STABfunP(Target(1).a, Target(1).pmass, Target(1).e, Target(1).smass, Imin, Imax); % Obtain C conditional density function
dnsfunH = STABfunH(Target(1).a, Target(1).pmass, Target(1).e, Target(1).smass, Imin, Imax); % Obtain r conditional density function
dnsfunG = STABfunG(Target(1).a, Target(1).pmass, Target(1).e, Target(1).smass, Imin, Imax); % Obtain C conditional density function


for j = 1 : length(Mvect)        % Iterate over mass vector  
    for i = 1 : length(avect)    % Iterate over the sma vector
        if Imin == Imax          % Check if system's inclination is known
            MatStabP(j, i) = dnsfunP(Mvect(j), avect(i));   % Directly calculate probability value
            MatStabH(j, i) = dnsfunH(Mvect(j), avect(i));   % Directly calculate probability value
            MatStabG(j, i) = dnsfunG(Mvect(j), avect(i));
        else
            MatStabP(j, i) = integral(@(I) dnsfunP(Mvect(j), avect(i), I), Imin, Imax, 'Reltol', 1e-5); % Integrate over the system's inclination
            MatStabH(j, i) = integral(@(I) dnsfunH(Mvect(j), avect(i), I), Imin, Imax, 'Reltol', 1e-5); % Integrate over the system's inclination
            if avect(i) < Target(1).a
                if Target(1).pmass >= (((1 / 1.46) ^ (7 / 2)) * Target(1).smass - Mvect(j))
                    MatStabG(j, i) = 0;
                else
                    IminMod = asin(Target(1).pmass / (((1 / 1.46) ^ (7 / 2)) * Target(1).smass - Mvect(j)));
                    ImaxMod = pi - IminMod;   
                    MatStabG(j, i) = integral(@(I) dnsfunG(Mvect(j), avect(i), I), IminMod , ImaxMod, 'Reltol', 1e-5); % Integrate over the system's inclination 
                end                    
            else
                MatStabG(j, i) = integral(@(I) dnsfunG(Mvect(j), avect(i), I), Imin , Imax, 'Reltol', 1e-5); % Integrate over the system's inclination
            end
        end
    end
end



end

