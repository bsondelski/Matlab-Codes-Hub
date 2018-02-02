function [ minMass ] = minimizeTotalMass( desiredPower,p1,T4,PR_c,T_amb,fluid,mode )
% gives minimum system mass for a cycle with a specified power output

% Inputs:
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs: 
% minMass: lowest possible total system mass for system with desired 
% power output 

A_panel_min = 40;
A_panel_max = 120;
[A_panel,minMass] = fminbnd(@minRadRecMass2,A_panel_min,A_panel_max,[],desiredPower,p1,T4,PR_c,...
    T_amb,fluid,mode);


end

