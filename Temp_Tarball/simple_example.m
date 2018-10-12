% This file contains a few examples of how to call the FIT Toolbox functions.
% Each FIT Toolbox function is named according to the known thermodynamic
% properties that will be provided to it.  The available functions are:
%
%   CO2_TD, CO2_TP, CO2_PH, CO2_PS, CO2_TQ, CO2_PQ, CO2_UD, CO2_HS
%
% More information about each function is available using the
% 'help' command in the Command Window.  For example: help CO2_TP


% Calculate density, specific enthalpy, and specific entropy given temperature and pressure.
T = 350;   % temperature in K
P = 8000;  % pressure in kPa
[D, H, S] = CO2_TP(T, P, 'dens', 'enth', 'entr');
fprintf('T = %g K\nP = %g kPa\nD = %g kg/m3\nH = %g kJ/kg\nS = %g kJ/kg-K\n', T, P, D, H, S);

% Call CO2_PH and CO2_PS to verify temperature from above matches.
fprintf('T from CO2_PH = %g K\n', CO2_PH(P, H, 'temp'));
fprintf('T from CO2_PS = %g K\n', CO2_PS(P, S, 'temp'));

% Calculate a number of two-phase properties.
[P_sat, H_sat, D_sat, S_sat] = CO2_TQ(280, 0.5, 'pres', 'enth', 'dens', 'entr');
fprintf('\nAt 280 K and and a quality of 0.5:\n')
fprintf('  D_sat = %g kg/m3\n  P_sat = %g kPa\n  H_sat = %g kJ/kg\n  S_sat = %g kJ/kg-K\n', D_sat, P_sat, H_sat, S_sat);

% Call CO2_HS at the same two-phase condition from above.
[quality, T_sat] = CO2_HS(H_sat, S_sat, 'qual', 'temp');
fprintf('Quality and temperature from CO2_HS call are %g and %g K\n\n', quality, T_sat);

% Calculate viscosity given temperature and density.
T = 500;                      % temperature in K
D = 200;                      % density in kg/m3
visc = CO2_TD(T, D, 'visc');  % viscosity in µPa-s
fprintf('Viscosity is %g µPa-s at a temperature of %g K and a density of %g kg/m3\n', visc, T, D);
