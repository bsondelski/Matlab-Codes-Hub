function [ UA_guess ] = maxPowerBoundFind( desiredPower,p1,T4,PR_c,...
    A_panel,T_amb,fluid,mode )
% find bounds for matching max power

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
% UA_guess: closest conductance [W/K] to solution with max power at desired
% power

UA_testvals = [5000,10000,15000,25000,50000];
for i = 1:length(UA_testvals)
        [err(i)] = maxPowerError( UA_testvals(i),desiredPower,p1,T4,...
            PR_c,A_panel,T_amb,fluid,mode );
   
end
[~,inde] = min(abs(err));
 
UA_guess = UA_testvals(inde);

end

