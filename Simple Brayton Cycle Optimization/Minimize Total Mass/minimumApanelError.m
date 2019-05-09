function [ err ] = minimumApanelError( A_panel,UA,desiredPower,p1,T4,PR_c,...
    T_amb,fluid,mode,options )
% error between max power of guessed UA and desired power

% Inputs: 
% A_panel: area of radiator panel [m2]
% UA: guessed UA value
% desiredPower: desired system power [w]
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation

% Outputs:
% err: error between max power of guessed UA and desired power


[maxPower,~] = findMaxPowerGivenUA(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options);
err = maxPower-desiredPower;

end
