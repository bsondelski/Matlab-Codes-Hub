function [ mass_total,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = totalMass( UA,desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode,m_dotcycle_max,options,NucFuel,RecupMatl)

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
% NucFuel: 'UO2' for uranium oxide (near term), 'UW' for uranium tunsten
% (exotic)
% RecupMatl: 'IN' for Inconel, 'SS' for stainless steel, 
%   for recuperator far term exploration, use 'U#' -
%   uninsulated, # of units, 'I#' -insulated, # of units
%   (all units are Inconel for these cases)

% Outputs: 
% mass_total: total system mass for system with desired power output and
% recuperator conductance

% find heat output for reactor for specified recuperator
[~,~,~,~,~,~,q_reactor,~,~,m_dot,T3,p3,T4,p4,T5,p5,~,p2,~,~] = SpecifiedPower2(desiredPower,...
    p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,m_dotcycle_max,options);


if isnan(m_dot)
    mass_total = NaN;
    mass_reactor = NaN;
    mass_recuperator = NaN;
    mass_radiator = NaN;
    m_dot = NaN;
else
    
    %%%%% original
    % mass_reactor = 0.00131*q_reactor+100;
    % mass_recuperator = 0.0131*UA; %convert to kW/K
    % mass_radiator = 5.8684*A_panel;
    
    % call to python
    % ploss_reactor = 0.0270;   % pressure drop in reactor
    % p4 = p3-p3*ploss_reactor; % pressure at reactor outlet
    mass_reactor = ReactorMass(q_reactor,m_dot,p3,p4,T3,T4,fluid,NucFuel);
    
    mass_recuperator = RecuperatorMass( p2,T5,p5,RecupMatl,UA,fluid,mode );
    
    mass_radiator = 6.75*A_panel;
    
    mass_total = mass_reactor+mass_recuperator+mass_radiator;
end
end

