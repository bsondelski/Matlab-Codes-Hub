function [p_out,T_out,D,Power,Ma,Anozzle,h2a] = TurbineOld(m_dot,T_in,p_in,p_out,fluid,mode,N)
%Computes the outlet conditions of the turbine and other performance
%quantities
%Inputs:
%m_dot: the mass flow into the turbine [kg/s]
%T_in: flow temp at inlet of the turbine [K]
%p_in: flow pressure at inlet of the turbine [kPa]
%PR: pressure ratio of the turbine inlet to outlet
%fluid: working fluid for the system
%N: shaft speed [rad/s]
%Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%Outputs:
%p_out: flow pressure at outlet of the turbine [kPa]
%T_out: flow temp at outlet of turbine [K]
%D: the diameter of the rotor in the turbine (turbine diameter) [m]
%Power: the power supplied by the turbine [W]
%Ma: the mach number of the turbine outlet
%Anozzle: the effective nozzle area 

%known values
V=0.7;                  %velocity ratio of tip velocity to spouting velocity
n_T=0.8;                %isentropic turbine efficiency

%find properties at turbine inlet
[s1, ~, h1]=getPropsTP(T_in,p_in,fluid,mode,2);
%returns entropy [J/kg-K], enthalpy [J/kg]

%find the isentropic outlet entropy
h2s=getPropsPS(s1,p_out,fluid,mode);
%renurns enthalpy [J/kg]

%solve for enthalpies and power
h_12s=h2s-h1;           %enthaply change if the system were isentropic[J/kg]
Power=m_dot*h_12s*n_T;  %calculate power from isentropic efficiency[W]
h2a=Power/m_dot+h1;     %calculate actual outlet enthalpy

%solve for turbine diameter
C_s=sqrt(abs(2*h_12s));         %spouting velocity
[T_out,a,rho2]=getPropsPH(p_out,h2a,fluid,mode,3);   %calculate temp at outlet of turbine[K]
Anozzle=m_dot/(C_s*rho2);       %the effective nozzle area 

%solve for mach number and shaft speed
u_t=V*C_s;                      %calculate tip speed
Ma=u_t/a;                       %mach number at exit
D=2*u_t/N;                      %calculate the diameter of the turbine
end

