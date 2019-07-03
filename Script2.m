%% Main Script
% Description: This script computes  and saves the analytic stability maps 
% of a system, using Petrovich's, Giuppone's and the Hill AMD stability
% criteria. By convolving them with the correspoding depth-of-search and occurrence
% grids, the expected number of stable and imageable planets in a system 
% according to each criteria is obtained.

% References: 

clear all; close all; clc;

%% Target Data 

% Define TargetList struct: {'System Name', 'planet letter'}
TargetList = {'GJ 411' 'b'};
%TargetList = {'Proxima Cen' 'b';'GJ 411' 'b';'eps Eri' 'b';'Ross 128' 'b';'GJ 674' 'b';'GJ 687' 'b';'HD 180617' 'b';'GJ 625' 'b';'Gl 686' 'b';'GJ 849' 'b';'GJ 433' 'b';'HD 102365' 'b';'HD 285968' 'b';'GJ 436' 'b';'GJ 1265' 'b';'HD 62509' 'b';'GJ 649' 'b';'GJ 536' 'b';'HD 147379' 'b';'GJ 86' 'b';'HD 3651' 'b';'HD 85512' 'b';'GJ 96' 'b';'GJ 179' 'b';'HD 147513' 'b';'HD 211970' 'b';'gam Cep' 'b';'GJ 685' 'b';'HIP 79431' 'b';'Gl 378' 'b';'51 Peg' 'b';'tau Boo' 'b';'HD 177565' 'b';'GJ 3942' 'b';'HR 810' 'b';'HD 10647' 'b';'GJ 3021' 'b';'70 Vir' 'b';'14 Her' 'b';'HD 99492' 'b';'HD 27442' 'b';'HD 154345' 'b';'HD 87883' 'b';'HD 192263' 'b';'7 CMa' 'b';'alf Ari' 'b';'HD 114613' 'b';'HD 104067' 'b';'alf Tau' 'b';'GJ 328' 'b';'HD 33564' 'b';'16 Cyg B' 'b';'HD 210277' 'b';'HD 90156' 'b';'HD 4308' 'b';'psi 1 Dra B' 'b';'HD 19994' 'b';'HD 39855' 'b';'HIP 12961' 'b';'HIP 70849' 'b';'HD 156668' 'b';'HD 42618' 'b';'HD 16417' 'b';'HD 128356' 'b';'HD 30562' 'b';'HD 103949' 'b';'HD 216437' 'b';'BD-11 4672' 'b';'HD 179949' 'b';'HD 114386' 'b';'HD 125595' 'b';'HD 164595' 'b';'HD 150706' 'b';'HD 93083' 'b';'HD 204941' 'b';'HD 218566' 'b';'HD 111232' 'b';'HD 75289' 'b';'HD 21411' 'b';'HD 219077' 'b';'HD 70642' 'b';'HD 102195' 'b';'HD 46375' 'b';'HD 52265' 'b';'HD 101930' 'b';'kap CrB' 'b';'HD 8326' 'b';'HD 162020' 'b';'HD 29021' 'b';'HD 221420' 'b';'HD 50554' 'b';'HD 64114' 'b';'iot Dra' 'b';'HD 130322' 'b';'HD 89307' 'b';'HIP 71135' 'b';'HD 117207' 'b';'HD 98736' 'b';'HD 63765' 'b';'HD 22781' 'b';'mu Leo' 'b';'HD 197037' 'b';'HD 216435' 'b';'HD 10697' 'b';'HIP 35173' 'b';'HD 141937' 'b';'HD 23079' 'b';'HD 85390' 'b';'HD 106515 A' 'b';'HD 40979' 'b';'HD 196885' 'b';'HD 4208' 'b';'HD 142022 A' 'b';'HD 81040' 'b';'BD-17 63' 'b';'HD 45652' 'b';'HD 142415' 'b';'HD 20782' 'b';'HD 7199' 'b';'HD 113337' 'b';'HD 216770' 'b';'HD 42012' 'b';'HD 25015' 'b';'HD 195019' 'b';'HD 63454' 'b';'HD 117618' 'b';'HD 16141' 'b';'HD 114729' 'b';'HD 8673' 'b';'HD 38283' 'b';'HD 32963' 'b';'HD 106252' 'b';'gam 1 Leo' 'b';'HD 89744' 'b';'HD 7449' 'b';'bet UMi' 'b';'HD 108147' 'b';'HD 164604' 'b';'HD 28185' 'b';'HD 102117' 'b';'HD 196067' 'b';'HD 114762' 'b';'HD 137388' 'b';'HD 213240' 'b';'HD 83443' 'b';'HD 178911 B' 'b';'HD 103720' 'b';'HD 168746' 'b';'HD 121504' 'b';'HD 4113' 'b';'HD 222582' 'b';'HD 98649' 'b';'HD 210193' 'b';'HD 6434' 'b';'HD 49674' 'b';'HD 13724' 'b';'HD 92987' 'b';'HD 208487' 'b';'91 Aqr' 'b';'HD 17674' 'b';'30 Ari B' 'b';'HD 171238' 'b';'HD 8574' 'b';'HD 285507' 'b';'HD 166724' 'b';'HD 330075' 'b';'HD 70573' 'b';'HD 86226' 'b';'HIP 91258' 'b';'HD 187085' 'b';'HD 77338' 'b';'HD 24040' 'b';'HD 220689' 'b';'HD 45350' 'b';'HD 133131 B' 'b';'HD 13931' 'b';'HD 20868' 'b';'HD 156846' 'b';'HD 181234' 'b';'HD 153950' 'b';'HD 143105' 'b';'HD 220773' 'b';'HD 79498' 'b';'eps Tau' 'b';'HD 108341' 'b';'BD+14 4559' 'b';'HD 107148' 'b';'HD 100777' 'b';'HD 167042' 'b'};
Targets = ImportData(TargetList);

%% Initialization
Na = 100;                                    % Number semi-major axis of bins
Nm = 100;                                    % Number of mass bins
Nr = 100;                                    % Number of radius bins

%% Compute (a, m) Stability Grids
amin = 1.5;                                  % Define minimum semi-major axis in (AU)
amax = 25;                                   % Define maximum semi-major axis in (AU)
Rmin = 4;                                    % Define minimum planetary radius in Earth Radius
Rmax = 17;                                   % Define maximum planetart radius in Earth Radius
avect = logspace(log10(amin), log10(amax), Na);                                 % Define array of semi-major axis points  
mvect = logspace(log10(MfromR(Rmin)), log10(MfromR(Rmax)), Na);                 % Define array of mass points                

for k = 1 : length(Targets)                  % Iterate over the number of targets
    
    [MatStabP, MatStabH, MatStabG] = STABmat(avect, mvect, Targets{k});         % Obtain stability matrices
    generatemassplotsep(avect, mvect, MatStabP, MatStabH, MatStabG, Targets{k}) % Generate plots
   
end
%% Compute (a, R) Stability Grids and Occurrence Grids
GStabP = zeros(Nr, Na);                     % Initialize Stability matrix for Petrovich's Criterion
GStabH = zeros(Nr, Na);
GStabG = zeros(Nr, Na);
GOcc = zeros(Nr, Na);

for k = 1 : length(Targets)
    Limits = importdata(['Datalimits/',Targets{k}.system,'limits.mat']);
    amin = Limits(1); amax = Limits(2); Rmin = Limits(3); Rmax = Limits(4);
    amin = 2.6;
    amax = 23;
    Rmin = 4.2;
    Rmax = 17;
    avect = logspace(log10(amin), log10(amax), Na + 1);
    Rvect = logspace(log10(Rmin), log10(Rmax), Nr + 1);
    mvect = MfromR(Rvect);
    
    [MatStabP, MatStabH, MatStabG]  = STABmat(avect, mvect, Targets{k});
    
    for i = 1 : Na
        for j = 1 : Nr
            GStabP(j, i) = ((MatStabP(j, i) +  MatStabP(j + 1, i)  ...
                             + MatStabP(j, i + 1) + MatStabP(j + 1, i + 1)) / 4); 
            GStabH(j, i) = ((MatStabH(j, i) +  MatStabH(j + 1, i)  ...
                             + MatStabH(j, i + 1) + MatStabH(j + 1, i + 1)) / 4);
            GStabG(j, i) = ((MatStabG(j, i) +  MatStabG(j + 1, i)  ...
                             + MatStabG(j, i + 1) + MatStabG(j + 1, i + 1)) / 4);
        end
    end
    
    %save(['StabGrids/' Targets{k}.system '_H'], 'GStabH')
    %save(['StabGrids/' Targets{k}.system '_P'], 'GStabP')
    %save(['StabGrids/' Targets{k}.system '_G'], 'GStabG')
   
    MatOcc = SAG13mat(avect, Rvect);
    
    for i = 1 : Na
       for j = 1 : Nr
            GOcc(j, i) = ((MatOcc(j, i) +  MatOcc(j + 1, i)  ...
                             + MatOcc(j, i + 1) + MatOcc(j + 1, i + 1)) / 4) * ((Rvect(j + 1) - Rvect(j)) * (avect(i + 1) - avect(i)));       
       end
    end
    
    %save(['OccGrids/' Targets{k}.system], 'GOcc')
    k
end

%% Import Data and Convolve Grids
StabDoSH = zeros(1, length(Targets));
StabDoSP = zeros(1, length(Targets));
StabDoSG = zeros(1, length(Targets));

StabCompH = zeros(1, length(Targets));
StabCompP = zeros(1, length(Targets));
StabCompG = zeros(1, length(Targets));

for k = 1 : length(Targets)
    Limits = importdata(['Datalimits/',Targets{k}.system,'limits.mat']);
    amin = Limits(1); amax = Limits(2); Rmin = Limits(3); Rmax = Limits(4);
    GStabH = importdata(['StabGrids/',Targets{k}.system,'_H.mat']);
    GStabP = importdata(['StabGrids/',Targets{k}.system,'_P.mat']);
    GStabG = importdata(['StabGrids/',Targets{k}.system,'_G.mat']);

    GOcc = importdata(['OccGrids/',Targets{k}.system,'.mat']);
    GDoS = importdata(['DoSGrids/',Targets{k}.system,'.mat']);
    
    GSDoSH = GStabH .* GDoS;
    GSDoSP = GStabP .* GDoS;
    GSDoSG = GStabG .* GDoS;
    
    GScompH = GSDoSH .* GOcc;
    GScompP = GSDoSP .* GOcc;
    GScompG = GSDoSG .* GOcc;
    
    %save(['TotalGrids/' Targets{k}.system], 'GScompH')
    %save(['TotalGrids/' Targets{k}.system], 'GScompP')
    %save(['TotalGrids/' Targets{k}.system], 'GScompG')
    
    StabDoSH(k) = (sum(sum(GSDoSH)) * ((amax - amin) * (Rmax - Rmin))) / (Na * Nr);
    StabDoSP(k) = (sum(sum(GSDoSP)) * ((amax - amin) * (Rmax - Rmin))) / (Na * Nr);
    StabDoSG(k) = (sum(sum(GSDoSG)) * ((amax - amin) * (Rmax - Rmin))) / (Na * Nr);
   
    StabCompH(k) = sum(sum(GScompH));
    StabCompP(k) = sum(sum(GScompP));  
    StabCompG(k) = sum(sum(GScompG));  
end
Targetsmat = cell2mat(Targets);
distvect = [Targetsmat.dist];
Res2 = table(TargetList, distvect', StabDoSP', StabCompP', StabDoSG' , StabCompG', StabDoSH' , StabCompH');
%save('Res', 'Res')
