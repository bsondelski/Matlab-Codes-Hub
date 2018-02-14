function [max_power,m_dot] = findMaxPower2(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options)
% find maximum power output and corresponding mass flow rate for a given
% conductance and other system parameters

% inputs:
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% UA: conductance of recuperator [W/K]
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% max_power: maximum output power from a given cycle found by varying m_dot
% [W]
% m_dot: the mass flow in the cycle with the max power [kg/s]


[m_dot,net_power] = fminbnd(@powerFind,0.5,3.5,options,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);

max_power = -net_power;
end

