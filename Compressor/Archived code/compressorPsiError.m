function [ err,u_t,D,eta_c,N ] = compressorPsiError( psi,h_12s,V_dot)
% gives error between guessed and actual head coefficient
%
% Inputs:
% psi: dimensionless head coefficient
% h_12s: isentropic enthalpy change [J/kg]
% V_dot: volumetric flow rate [m3/s]
%
% Outputs:
% err: error between guessed and actual head coefficient

% find the diameter of the compressor at current conditions
u_t = sqrt(h_12s/psi);          % compressor rotor tip velocity [m/s]
Dguess = CompressorDBoundFind(u_t,V_dot,h_12s);
D = fzero(@compressorDError,Dguess,[],u_t,V_dot,h_12s);
[~,n_s,N] = compressorDError(D,u_t,V_dot,h_12s);

[eta_c,~] = compressorEfficiencyOld(n_s,inf);

% %forcing to be n_c max
% [ ~, n_c ] = CompressorDFind( u_t,V_dot,h_12s );
%
%
% % Dguess = CompressorDBoundFind(u_t,V_dot,h_12s);
% % D = fzero(@compressorDError,Dguess,[],u_t,V_dot,h_12s);
% %
% % N = 2*u_t/D;              %calculate the shaft speed of the compressor in [rad/s]
% % n_s = N*sqrt(V_dot)/h_12s^(3/4);  %calculate specific speed
% %
% % d_s = D*h_12s^(1/4)/sqrt(V_dot);
% % [n_c,~] = compressorEfficiency(n_s,d_s);       %isentropic compressor efficiency

n_c_max = 0.871051704626864;
psi_max = 0.62;

psi_est = (eta_c/n_c_max)^1*psi_max;	% head coefficient scaled by efficiency
err = psi-psi_est;

end

