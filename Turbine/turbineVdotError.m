function [ err ] = turbineVdotError( V_dot,N,h_12s,m_dot,h1,p_out,fluid,mode )
%Computes the outlet conditions of the turbine and other performance
%quantities
%Inputs:
%V_dot: guessed vol flow rate [m^3/s]
%N: shaft speed [rad/s]
%h_12s: isentropic enthalpy change [J/kg]
%m_dot: the mass flow into the turbine [kg/s]
%h1: inlet enthalpy [J/kg]
%p_out: outlet pressure [kPa]
%fluid: working fluid for the system
%Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%Outputs:
%error: difference between input volumetric flow rate and calculated
%volumetric flow rate


n_s=N*sqrt(V_dot)/h_12s^(3/4);      %specific speed
%efficiency and specific diameter
[n_T,~]=turbineEfficiency(n_s,inf);

Power=m_dot*h_12s*n_T;  %calculate power from isentropic efficiency[W]
h2a=h1-Power/m_dot;     %calculate actual outlet enthalpy

%solve for turbine diameter
[~,~,rho2]=getPropsPH(p_out,h2a,fluid,mode,3);   %calculate temp at outlet of turbine[K]
V_new=m_dot/rho2;       %calculate volumetric flow rate from mass flow rate and density
err=V_new-V_dot;            %error between guessed vol flow rate and calculated one

end

