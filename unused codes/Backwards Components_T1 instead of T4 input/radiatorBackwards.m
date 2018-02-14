function [T_in,p_in] = radiatorBackwards(m_dot,A_panel,T_amb,T_out,p_out,fluid,mode)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%known vals
eps=0.8;            %emissivity 
T12_pp=100;         %Pressure point temp change [K]
p12=100;            %pressure change [kPa]
sigma=5.670367E-8;  %Stefan-Boltzmann constant [W/m2-K4]

p_in=p_out-p12;     %calculate inlet pressure[kPa]

[~,~,h_out]=getPropsTP(T_out,p_out,fluid,mode,1);       %outlet enthalpy from outlet temp[J/kg]
T_panel=T12_pp-T_out;                                   %find panel temp[K]
q_rad=A_panel*eps*sigma*(T_panel^4-T_amb^4);             %radiative heat transfer equation
h_in=q_rad/m_dot+h_out;                                 %inlet enthalpy
[T_in,~,~]=getPropsPH(p_in,h_in,fluid,mode,1);           %find inlet temp[K]
end

