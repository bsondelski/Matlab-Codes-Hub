function [ UA_min,UA_max ] = minimumUABoundFind( desiredPower,p1,T4,PR_c,...
    A_panel,T_amb,fluid,mode )
% find bounds for selecting the minimum UA

% Inputs:
% desiredPower: desired system power [w]
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation

% Outputs:
% UA_min,UA_max: range of conductances [W/K] where solution with max power at desired
% power lies

% arbitrary starting values
UA_min = 100;
UA_max = 20000;
steps = 10;


a = 1;
j = 0;  % counter

while a == 1 %|| j < 3
    UA_testvals = linspace(UA_min,UA_max,steps);
    
    options = [];
    
    % preallocate space
    err = zeros(1,steps);

    for i = 1:length(UA_testvals)
        [err(i)] = minimumUAError( UA_testvals(i),desiredPower,p1,T4,...
            PR_c,A_panel,T_amb,fluid,mode,options );
        if i > 1 && abs(err(i)) > abs(err(i-1))
            % if error is getting farther from zero, the solution has
            % already been passed -no need to calculate the other values
            err(i+1:end) = [];
            break
        end
    end
    
    [~,inde] = min(abs(err));
    
    if inde == 1
        if isnan(err(inde+1))
            UA_min = UA_testvals(inde);
            UA_max = UA_testvals(inde+1);
        elseif -sign(err(inde)) == sign(err(inde+1))
            UA_min = UA_testvals(inde);
            UA_max = UA_testvals(inde+1);
            a = 0;
        else
            UA_min = UA_min/2;
            UA_max = UA_testvals(inde+1);
        end
        
    elseif inde == steps
        if -sign(err(inde)) == sign(err(inde-1))
            UA_min = UA_testvals(inde-1);
            UA_max = UA_testvals(inde);
            a = 0;
        else
            UA_max = UA_max*1.5;
            UA_min = UA_testvals(inde-1);
        end
        
    else
        if isnan(err(inde+1))
            UA_min = UA_testvals(inde-1);
            UA_max = UA_testvals(inde+1);
        elseif sign(err(inde)) == sign(err(inde-1)) && sign(err(inde)) == sign(err(inde+1))
            fprintf(2, 'maxPowerBoundFind: 40 kW cannot be reached at this Apanel \n \n');
            UA_min = NaN;
            UA_max = NaN;
            break
        else
            UA_min = UA_testvals(inde-1);
            UA_max = UA_testvals(inde+1);
            a = 0;
        end
    end
    
    j = j + 1;
    if UA_max > 150000 || UA_min < 50
        fprintf(2, 'maxPowerBoundFind: recuperator too small or large \n \n');
        UA_min = NaN;
        UA_max = NaN;
        break
    end
    
    % check if stuck in the loop
    UA_diff = UA_max - UA_min;
    if UA_diff < 1  && a == 1
        fprintf(2, 'maxPowerBoundFind: unable to find UA boundaries \n \n');
        UA_min = NaN;
        UA_max = NaN;
        break
    end
    
end


end











