function [ Dguess ] = CompressorDBoundFind( u_t,V_dot,h_12s )
% obtain an accurate guess value for compressor diameter
% 
% Inputs:
% u_t: tip belocity of the compressor rotor [m/s]
% V_dot: volumetric flow rate [m3/s]
% h_12s: isentropic enthalpy change [J/kg]
% 
% Outputs:
% Dguess: guess value for compressor diameter
 
Dmin = 0.0001;
Dmax = 0.05;
 
D = linspace(Dmin,Dmax,40);
N = 2*u_t./D;
n_s = N*sqrt(V_dot)/h_12s^(3/4);
d_s = D*h_12s^(1/4)/sqrt(V_dot);
 

[n_c,~] = compressorEfficiency(n_s,d_s);

% n_c = zeros(1,length(D));
%  
% for i = 1:length(D)
%     [n_c(i),~] = compressorEfficiencyOld(n_s(i),d_s(i)); 
% end 

[~,inde] = max(n_c);
% Dmin = D(inde-2);
% Dmax = D(inde+2);
Dguess = D(inde);
 
end


