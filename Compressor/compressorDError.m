function [ err,n_s,N ] = compressorDError(D,u_t,V_dot,h_12s)
% Gives error between guess value for compressor diameter and acutal
% compressor diameter
%
% Inputs:
% D: guess value for compressor diameter [m]
% u_t: tip velocity of the compressor rotor [m/s]
% V_dot: volumetric flow rate [m3/s]
% h_12s: isentropic enthalpy change [J/kg]
%
% Outputs:
% err: error between diameter guess value and actual value

% specific diameter at current parameters along peak efficiency curve
N = 2*u_t/D;                              % compressor shaft speed [rad/s]
n_s = N*sqrt(V_dot)/h_12s^(3/4);          % specific speed

[~,d_s] = compressorEfficiencyOld(n_s,inf);  % specific diameter

% error between guessed diameter and diameter found from specific diameter
D_est = d_s*sqrt(V_dot)/h_12s^(1/4);      % diameter [m]
err = D-D_est;

end


