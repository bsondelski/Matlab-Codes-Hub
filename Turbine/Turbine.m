function [p_out,T_out,D,Power,Ma,Anozzle,h2a,Vratio] = Turbine(m_dot,T_in,p_in,p_out,fluid,mode,N)
% Computes the outlet conditions of the turbine and other performance
% quantities

% Inputs:
% m_dot: the mass flow into the turbine [kg/s]
% T_in: flow temp at inlet of the turbine [K]
% p_in: flow pressure at inlet of the turbine [kPa]
% P_out: outlet pressure of the turbine [kPa]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% N: shaft speed [rad/s]

% Outputs:
% p_out: flow pressure at outlet of the turbine [kPa]
% T_out: flow temp at outlet of turbine [K]
% D: the diameter of the rotor in the turbine (turbine diameter) [m]
% Power: the power supplied by the turbine [W]
% Ma: the mach number of the turbine outlet
% Anozzle: the effective nozzle area [m^2]
% h2a: actual outlet enthalpy [J/kg]
% Vratio: velocity ratio

% find properties at turbine inlet
[s1, rho1, h1] = getPropsTP(T_in,p_in,fluid,mode,2);
% returns entropy [J/kg-K], density [kg/m^3] enthalpy [J/kg]

% find the isentropic outlet entropy
[h2s,~] = getPropsPS(s1,p_out,fluid,mode,1);
% returns enthalpy [J/kg]

% solve for enthalpies and power
h_12s = h1-h2s;           % isentropic enthaply change [J/kg]
% use fzero to get V [m^3/s]
V_dotguess = m_dot/rho1*p_in/p_out;
V_dot = fzero(@turbineVdotError,V_dotguess,[],N,h_12s,m_dot,h1,p_out,fluid,mode);

n_s = N*sqrt(V_dot)/h_12s^(3/4);      % specific speed
% efficiency and specific diameter
[n_T,d_s] = turbineEfficiency(n_s,inf);

Power = m_dot*h_12s*n_T;  % calculate power from isentropic efficiency [W]
h2a = h1-Power/m_dot;     % calculate actual outlet enthalpy [J/kg]

% solve for turbine diameter
[T_out,a,rho2] = getPropsPH(p_out,h2a,fluid,mode,3);   
C_s = sqrt(abs(2*h_12s));         % spouting velocity
Anozzle = m_dot/(C_s*rho2);       % the effective nozzle area [m^2]
D = d_s*sqrt(V_dot)/h_12s^(1/4);

% solve for mach number and shaft speed
u_t = D*N/2;        %calculate tip speed
Vratio = u_t/C_s;	%velocity ratio of tip velocity to spouting velocity
Ma = u_t/a;         %mach number at exit
end

