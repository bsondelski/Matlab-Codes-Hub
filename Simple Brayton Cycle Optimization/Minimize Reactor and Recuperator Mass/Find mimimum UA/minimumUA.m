function [ UA,m_dot ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode)
% provides mimimum UA and corresponding mass flow rate to achieve the
% desired power at the specified panel area

% Inputs: 
% desiredPower: desired system power [w]
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor 
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% UA: conductance [W/K] that gives the max power equivalent to the desired
% power
% m_dot: mass flow rate at ideal power [kg/s]

[UA_min,UA_max] = minimumUABoundFind( desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode );

    

if UA_max > 60000 || UA_min < 5
    UA = NaN;
    m_dot = NaN;
elseif isnan(UA_min)
    UA = NaN;
    m_dot = NaN;
else
    options = [];
    UA = fzero(@minimumUAError,[UA_min,UA_max],[],desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode,options);
    
    [~,m_dot] = findMaxPowerGivenUA(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options);
end

end

