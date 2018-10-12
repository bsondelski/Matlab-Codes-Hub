function [T_out,D,N,Power,Ma,h2a] = CompressorLoops(m_dot,T_in,p_in,p_out,fluid,mode)
% Computes the outlet conditions of the compressor and other performance
% quantities
%
% Inputs:
% m_dot: the mass flow into the compressor [kg/s]
% T_in: flow temp at inlet of the compressor [K]
% p_in: flow pressure at inlet of the compressor [kPa]
% p_out: flow pressure at outlet of the compressor [kPa]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%
% Outputs:
% T_out: flow temp at outlet of compresor [K]
% D: the diameter of the rotor in the compressor (compressor diameter) [m]
% N: the shaft speed of the compressor [rad/s]
% Power: the power consumed by the compressor [W]
% Ma: the mach number of the compressor outlet
% h2a: enthalpy of the flow at the outlet of the compressor [J/kg]


% get initial properties
% compressor inlet - s [J/kg-K], rho [kg/m3], h [J/kg]
[s1, rho1, h1] = getPropsTP(T_in,p_in,fluid,mode,2);
% isentropic outlet enthalpy [J/kg]
[h2s,~] = getPropsPS(s1,p_out,fluid,mode,1);
h_12s = h2s-h1;             % isentropic enthaply change [J/kg]
V_dot = m_dot/rho1;         % volumetric flow rate [m3/s]

% dimensionless head coefficient
psi = fzero(@compressorPsiError,[0.3, 0.62],[],h_12s,V_dot)

% find diameter and other info
[~,u_t,D,n_c,N ] = compressorPsiError(psi,h_12s,V_dot);

% psi = 0.6;
% u_t = sqrt(h_12s/psi);          % compressor rotor tip velocity [m/s]
% Dmin = 0.0001;
% Dmax = 0.05;
% D = linspace(Dmin,Dmax,50);
% 
% for i = 1:length(D)
%     [ err(i),n_s(i),N(i) ] = compressorDError(D(i),u_t,V_dot,h_12s);
%     [eta_c(i),~] = compressorEfficiency(n_s(i),inf);
% end
% 
% figure
% plot(D,err)
% figure
% plot(D,eta_c)

% calculate flow coefficient
Area = pi()*D^2/4;
phi = m_dot/(rho1*u_t*Area);

Power = m_dot*h_12s./n_c;  % [W]
h2a = Power./m_dot+h1;     % actual outlet enthalpy
% compressor outlet temperature [K]
[T_out,a,~] = getPropsPH(p_out,h2a,fluid,mode,2);
Ma = u_t/a;               % tip mach number
end

