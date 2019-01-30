function [T_out,D,N,Power,Ma,h2a] = Compressor(m_dot,T_in,p_in,p_out,fluid,mode)
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

% baseline case
psi = 0.6;
d_s = 3.842092247585562;
n_s = 0.672026784128928;
n_c = 0.853835338294150;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To find new values for the specific speed, specific diameter, efficiency,
% set a psi and run the four lines of code below and replace values above
% with the results.
% 
% psi = 0.64;
% d_s = fzero(@psiDiameterError,[2, 5],[],psi)
% [~,~,n_s] = psiDiameterError(d_s,psi)
% [n_c,~] = compressorEfficiencyOld(n_s,d_s)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get initial properties
% compressor inlet - s [J/kg-K], rho [kg/m3], h [J/kg]
[s1, rho1, h1] = getPropsTP(T_in,p_in,fluid,mode,2);
% isentropic outlet enthalpy [J/kg]
[h2s,~] = getPropsPS(s1,p_out,fluid,mode,1);
h_12s = h2s-h1;             % isentropic enthaply change [J/kg]
V_dot = m_dot/rho1;         % volumetric flow rate [m3/s]
u_t = sqrt(h_12s/psi);          % compressor rotor tip velocity [m/s]

D = d_s*sqrt(V_dot)/(h_12s^(1/4));
N = n_s*h_12s^(3/4)/sqrt(V_dot);

% calculate flow coefficient
Area = pi()*D^2/4;
phi = m_dot/(rho1*u_t*Area);

Power = m_dot*h_12s./n_c;  % [W]
h2a = Power./m_dot+h1;     % actual outlet enthalpy
% compressor outlet temperature [K]
[T_out,a,~] = getPropsPH(p_out,h2a,fluid,mode,2);
Ma = u_t/a;               % tip mach number
end

