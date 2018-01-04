function [ UA,m_dot ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode)
% provides error from max power with guessed input UA to actual desired
% power

UA_guess = maxPowerBoundFind( desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode );

UA = fzero(@maxPowerError,UA_guess,[],desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode);
[~,m_dot] = findMaxPower(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);

end

