function [q_rad,T_out] = Radiator(m_dot,A_panel,T_amb,T_in,p_in,p_out,fluid,mode)
%Radiator model
%inputs:
%m_dot: mass flow through radiator
%A_panel: area of the radiator panel that is transferring heat
%T_amb: temperature of surrounding space
%T_in: temp at inlet of radiator [K]
%p_in: pressure at inlet of radiator [kPa]
%fluid: fluid in HEX
%mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%output
%q_rad: heat transferred from the radiator to space [J/s]
%T_out: temperature of radiator outlet [K]

%known vals
eps=0.9;            %emissivity 
T12_pp=10;         %Pressure point temp change [K]
sigma=5.670367E-8;  %Stefan-Boltzmann constant [W/m2-K4]

[~,~,h_in]=getPropsTP(T_in,p_in,fluid,mode,1);  %get inlet enthalpy[J/kg]

%find bounds for fzero
[h_outmin,h_outmax] = RadiatorBoundFind(m_dot,A_panel,T_amb,fluid,mode,eps,T12_pp,sigma,h_in,p_out);

%use fzero to find actual enthalpy at outlet of radiator[J/kg]
h_out=fzero(@radiatorError,[h_outmin,h_outmax],[],h_in,m_dot,eps,T12_pp,p_out,sigma,A_panel,T_amb,fluid,mode);

q_rad=m_dot*(h_out-h_in);                               %heat transfer due to energy change[J/s]
T_panel=nthroot(-q_rad/(A_panel*eps*sigma)+T_amb^4,4);   %radiative heat transfer equation
T_out=T_panel+T12_pp;                                   %outlet temperature of fluid[K]
end

