function [ UA_min,UA_max ] = maxPowerBoundFind( desiredPower,p1,T4,PR_c,...
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

% arbitrary starting values
UA_min = 100;
UA_max = 20000;
steps = 10;

% low tolerance because rough estimate
% options = optimset('TolX',0.1);
% options = [];

% preallocate space
err = zeros(1,steps);

a = 1;
j = 0;  % counter


while a == 1 || j < 3
    UA_testvals = linspace(UA_min,UA_max,steps);
    
    if j ==1
        options = optimset('TolX',1);
    elseif j == 2
        options = optimset('TolX',0.01);
    else
        options = [];
    end
    
    parfor i = 1:length(UA_testvals)
        [err(i)] = maxPowerError( UA_testvals(i),desiredPower,p1,T4,...
            PR_c,A_panel,T_amb,fluid,mode,options );
    end

    [~,inde] = min(abs(err));
    
    if inde == 1
        if -sign(err(inde)) == sign(err(inde+1))
            UA_min = UA_testvals(inde);
            UA_max = UA_testvals(inde+1);
            a = 0;
        else
            UA_min = UA_min/steps;
            UA_max = UA_testvals(inde+1);
        end
        
    elseif inde == steps
        if -sign(err(inde)) == sign(err(inde-1))
            UA_min = UA_testvals(inde-1);
            UA_max = UA_testvals(inde);
            a = 0;
        else
            UA_max = UA_max + 10000;
            UA_min = UA_testvals(inde-1);
        end
        
    else
        UA_min = UA_testvals(inde-1);
        UA_max = UA_testvals(inde+1);
        a = 0;
    end
    
    j = j + 1;
    if UA_max > 60000 || UA_min < 100
        break
    end
end


% UA_guess = UA_testvals(inde);

end











