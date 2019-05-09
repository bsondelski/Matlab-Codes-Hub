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
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% m_dotcycle_max: maximum mass flow rate possible which will provide the
% desired power output
% NucFuel: 'UO2' for uranium oxide (near term), 'UW' for uranium tunsten
% (exotic)
% RecupMatl: 'IN' for Inconel, 'SN' for near term stainless steel, 'SF' for
%            far term stainless steel

% Outputs: 
% mass_total: total system mass for system with desired power output and
% recuperator conductance
% mass_reactor: reactor mass [kg]
% mass_recuperator: recuperator mass [kg]
% mass_radiator: radiator mass [kg]
% m_dot: mass flow rate [kg/s]

% find mass flow rate required to provide desired power with given
% recuperator size
[~,~,~,~,~,~,q_reactor,~,~,m_dot,T3,p3,T4,p4,T5,p5,~,p2,~,~] = SpecifiedPower2(desiredPower,...
    p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,m_dotcycle_max,options);


if isnan(m_dot)
    mass_total = NaN;
    mass_reactor = NaN;
    mass_recuperator = NaN;
    mass_radiator = NaN;
    m_dot = NaN;
else
    
    % get masses of all components
    
    % call to python
    mass_reactor = ReactorMass(q_reactor,m_dot,p3,p4,T3,T4,fluid,NucFuel);
    
    mass_recuperator = RecuperatorMass( p2,T5,p5,RecupMatl,UA,fluid,mode,m_dot );
    
    mass_radiator = 6.75*A_panel;
    
    mass_total = mass_reactor+mass_recuperator+mass_radiator;
end
end

