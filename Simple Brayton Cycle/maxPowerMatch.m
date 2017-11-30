function [ err ] = maxPowerMatch(UA,desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode)
%provides error from max power with guessed input UA to actual desired
%power

[max_power,~] = findMaxPower(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
err=max_power-desiredPower

end

