function [ mass_total,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = totalMass( UA,desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode,m_dotcycle_max,options)

% gives total system mass for a cycle with a specified recuperator
% conductance and power output

% Inputs:
% UA: guessed conductance of recuperator [W/K]
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% m_dotcycle_max: maximum mass flow rate possible which will provide the
% desired power output

% Outputs: 
% mass_total: total system mass for system with desired power output and
% recuperator conductance

% find heat output for reactor for specified recuperator
[~,~,~,~,~,~,q_reactor,~,~,m_dot,~,~,~,~] = SpecifiedPower2(desiredPower,...
    p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,m_dotcycle_max,options);

% find system mass
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = 0.0131*UA; %convert to kW/K
mass_radiator = 5.8684*A_panel;
mass_total = mass_reactor+mass_recuperator+mass_radiator;
end

