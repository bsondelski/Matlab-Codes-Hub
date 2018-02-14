function [err] = TurbineError(h1,p1,m_dot,PR,fluid,mode,N,T_out,V,n_T)
%Computes the outlet conditions of the turbine and other performance
%quantities
%Inputs:
%m_dot: the mass flow into the turbine [kg/s]
%T_in: flow temp at inlet of the turbine [K]
%p_in: flow pressure at inlet of the turbine [kPa]
%PR: pressure ratio of the turbine
%fluid: working fluid for the system
%N: shaft speed [rad/s]
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%Outputs:
%p_out: flow pressure at outlet of the turbine [kPa]
%T_out: flow temp at outlet of turbine [K]
%D: the diameter of the rotor in the turbine (turbine diameter) [m]
%Power: the power supplied by the turbine [W]
%Ma: the mach number of the turbine outlet
%Anozzle: the effective nozzle area 


%find properties at turbine inlet
[T1,~,~]=getPropsPH(p1,h1,fluid,mode,1);
[s1, ~, h1]=getPropsTP(T1,p1,fluid,mode,2);
%returns entropy [J/kg-K], density [kg/m3], enthalpy [J/kg]

p_out=p1*PR;          %find outlet pressure [kPa]

%find the isentropic outlet entropy
h2s=getPropsPS(s1,p_out,fluid,mode);
%renurns enthalpy [J/kg]

%solve for enthalpies and power
h_12s=h2s-h1;           %enthaply change if the system were isentropic[J/kg]
Power=m_dot*h_12s*n_T;  %calculate power from isentropic efficiency[W]
h2a=Power/m_dot+h1;     %calculate actual outlet enthalpy

%solve for outlet temp
[T_outguess,a,rho2]=getPropsPH(p_out,h2a,fluid,mode,3);   %calculate temp at outlet of turbine[K]
err=T_outguess-T_out
end
