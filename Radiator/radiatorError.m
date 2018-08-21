function [h_error] = radiatorError(h_outguess,h_in,m_dot,epsilon,T12_pp,p_out,sigma,A_panel,T_amb,fluid,mode,TFluidMin)
% find error between guessed enthalpy and the calculated enthalpy
% (calculated using the guessed enthalpy

% inputs:
% h_out: guessed enthalpy
% h_in: inlet enthalpy to radiator
% m_dot: mass flow through radiator
% eps: emissivity
% T12_pp: change in temp at the pinch point
% p_out: pressure at radiator outlet
% sigma: Stefan-Boltzmann constant
% A_panel: area of the radiator panel that is transferring heat
% T_amb: temperature of surrounding space
% fluid: fluid in HEX
% mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% output:
% h_error: error between guessed outlet enthalpy and the resulting outlet
% enthalpy from the heat transfer equations


q_rad = m_dot*(h_in-h_outguess);                        % heat transfer due to energy change[J/s]
T_panel = nthroot(q_rad/(A_panel*epsilon*sigma)+T_amb^4,4);	% radiative heat transfer equation
T_out = T_panel+T12_pp;                                 % outlet temperature of fluid[K]
if T_out < TFluidMin
    h_error = NaN;
else
    [~,~,h_out] = getPropsTP(T_out,p_out,fluid,mode,1);     % outlet enthalpy from outlet temp[J/kg]
    h_error = h_out-h_outguess;                             % error in enthalpy from guessed enthalpy[J/kg]
end

end

