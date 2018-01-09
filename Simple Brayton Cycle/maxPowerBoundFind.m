function [ UA_guess ] = maxPowerBoundFind( desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

UA_testvals = [5000,10000,15000,25000,50000];
for i = 1:length(UA_testvals)
   
        [err(i)] = maxPowerError( UA_testvals(i),desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode );
   
end
[~,inde] = min(abs(err));
 
UA_guess = UA_testvals(inde);
% if inde == 1
%     UA_min = UA_testvals(inde);
%     UA_max = UA_testvals(inde+1);
% else
%     UA_min = UA_testvals(inde-1);
%     UA_max = UA_testvals(inde+1);
% end

end

