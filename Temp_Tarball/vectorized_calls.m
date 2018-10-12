% This file contains a few examples of how to call the FIT Toolbox functions
% using vectorization, which significantly increases their speed compared to
% calling the functions in a loop with scalar values.
%
% Note that it is also faster to return all the desired properties in a
% single call, rather than calling the same function at the same state
% multiple times, once for each property. 


% Call CO2_TD with a single temperature and a vector of densities.
T = 700;                          % K
Ds = linspace(1, 200, 10);        % kg/m3
P_vector = CO2_TD(T, Ds, 'pres')  % kPa

% Call CO2_PH with an array of pressures and a single specific enthalpy.
P_array = [100, 1000; 500, 5000];  % kPa
enthalpy = 500;                    % kJ/kg     
[cond_array, entr_array] = CO2_PH(P_array, enthalpy, 'cond', 'entr')

% Call CO2_TP with vectors of temperature and pressure.
% Note the conversion from C and MPa to K and kPa within the CO2_TP call.
Ts = [32, 65, 500, 700, 600, 100];  % C
Ps = [8, 25, 25, 25, 8, 8];         % MPa
[Ds, Cps, Us, Hs, Ss] = CO2_TP(Ts+273.15, Ps*1000, 'dens', 'cp', 'inte', 'enth', 'entr')
