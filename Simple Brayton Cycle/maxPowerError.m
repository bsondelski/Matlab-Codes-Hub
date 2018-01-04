function [ err ] = maxPowerError( UA,desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode )
% UNTITLED4 Summary of this function goes here
% Detailed explanation goes here

[max_power,~] = findMaxPower(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
err = max_power-desiredPower;

end

