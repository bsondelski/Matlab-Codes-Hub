function [ err ] = minimumUAError( UA,desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode,options )
% error between max power of guessed UA and desired power

% Inputs: 
% UA: guessed UA value
% desiredPower: desired system power [w]
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor 
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% options: solving tolerance

% Outputs:
% err: error between max power of guessed UA and desired power


[max_power,~] = findMaxPowerGivenUA(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options);
err = max_power-desiredPower;

end

