function [q_rad,T_out,A_panel] = Radiator(m_dot,A_panel,T_amb,T_in,TFluidMin,p_in,p_out,fluid,mode)
% Radiator model

% inputs:
% m_dot: mass flow through radiator [kg/s]
% A_panel: area of the radiator panel that is transferring heat [m2]
% T_amb: temperature of surrounding space [K]
% T_in: temp at inlet of radiator [K]
% TFluidMin: minimum temperature available for fluid data [K]
% p_in: pressure at inlet of radiator [kPa]
% p_out: pressure at outlet of radiator [kPa]
% fluid: fluid in HEX
% mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% output:
% q_rad: heat transferred from the radiator to space [J/s]
% T_out: temperature of radiator outlet [K]
% A_panel: area of radiator panel [m^2]

% known vals
eps = 0.9;            % emissivity
T12_pp = 10;          % Approach temperature difference (pinch point) [K]
sigma = 5.670367E-8;  % Stefan-Boltzmann constant [W/m2-K4]

[~,~,h_in] = getPropsTP(T_in,p_in,fluid,mode,1); % inlet enthalpy [J/kg]

% find bounds for fzero
[h_outmin,h_outmax] = RadiatorBoundFind(m_dot,A_panel,T_amb,fluid,mode,...
    eps,T12_pp,sigma,h_in,p_out,TFluidMin);

if isnan(h_outmin) && isnan(h_outmax)
    % T1 wants to go below Tmin
    
    q_rad = NaN;
    T_out = NaN;
    A_panel = NaN;
else
    % normal results for working cycle
    
    % use fzero to find actual enthalpy at outlet of radiator [J/kg]
    h_out = fzero(@radiatorError,[h_outmin,h_outmax],[],h_in,m_dot,eps,...
        T12_pp,p_out,sigma,A_panel,T_amb,fluid,mode,TFluidMin);
    
    % heat transfer due to energy change[J/s]
    q_rad = m_dot*(h_out-h_in);
    % radiative heat transfer equation
    T_panel = nthroot(-q_rad/(A_panel*eps*sigma)+T_amb^4,4);
    % outlet temperature of fluid [K]
    T_out = T_panel+T12_pp;
end

end

