function [ minMass, UA,t ] = minRadRecMass2( A_panel,desiredPower,p1,T4,PR_c,T_amb,fluid,mode )
% gives minimum system mass for a cycle with a specified radiator area
% and power output

% Inputs:
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% minMass: lowest possible total system mass for system with desired
% power output and radiator area

tic

% find minimum UA which gives desired power output
[ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);





% find bounds for mass minimization
UA_max = UA_min + 10000;
options1 = optimset('TolX',10);
a = 1;
while a ==1
    UA = linspace(UA_min,UA_max,5);
    
    % preallocate space
    mass_total = zeros(1,length(UA));
    
    for i = 1:length(UA)
        [ mass_total(i) ] = totalMass( UA(i),desiredPower,p1,T4,PR_c,A_panel,...
            T_amb,fluid,mode,m_dotcycle_max,options1);
    end
    
    [~,inde] = min(mass_total);
    
    if inde == length(UA)
        UA_max = UA(length(UA))+ 10000;
        UA_min = UA(length(UA-1));
    else
        a = 0;
    end
    
%     if inde == 1
%         UA_max = UA(2);
%         a = 0;
%     elseif inde == length(UA)
%         UA_max = UA(length(UA))+ 10000;
%         UA_min = UA(length(UA-1));
%     else
%         UA_min = UA(inde-1);
%         UA_max = UA(inde+1);
%         a = 0;
%     end
    
end






% find recuperator conductance for cycle with minimum mass
options2 = [];
options3 = optimset('TolX',1e-2); 
[UA,minMass] = fminbnd(@totalMass,UA_min,UA_max,options3,desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode,m_dotcycle_max,options2);
t = toc;
end

