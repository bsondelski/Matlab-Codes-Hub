function [A_panel,q_rad] = radiator2(m_dot,T_amb,T_out,p_out,T_in,p_in,fluid,mode)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%known vals
eps=0.8;            %emissivity 
T12_pp=100;         %Pressure point temp change [K]
sigma=5.670367E-8;  %Stefan-Boltzmann constant [W/m2-K4]

[~,~,h_out]=getPropsTP(T_out,p_out,fluid,mode,1);       %outlet enthalpy from outlet temp[J/kg]
[~,~,h_in]=getPropsTP(T_in,p_in,fluid,mode,1);          %outlet enthalpy from outlet temp[J/kg]

T_panel=T12_pp-T_out;                                   %find panel temp[K]
q_rad=m_dot*(h_in-h_out);                               %inlet enthalpy
A_panel=q_rad/(eps*sigma*(T_panel^4-T_amb^4));          %radiative heat transfer equation
end

