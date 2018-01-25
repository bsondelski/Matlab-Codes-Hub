function [err] = specifiedPowerError(m_dot_guess,power,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode)
% find error in specified power for the guessed mass flow rate

% Inputs:
% m_dot_guess: the guessed mass flow in the cycle [kg/s]
% power: specified power for the system 
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% UA: conductance of recuperator [W/K]
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Output:
% err: error between specified power and power from guessed mass flow rate

[net_power,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = ...
    BraytonCycle(m_dot_guess,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);

err = power-net_power;


end

