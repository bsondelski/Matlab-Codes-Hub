function [minMass,UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot] = minRadRecMass( A_panel,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,check,tolerance,NucFuel,RecupMatl )
% gives minimum system mass for a cycle with a specified radiator area
% and power output

A_panel

% Inputs:
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% check: 1 (only provide minMass, UA, UA_min) 2 (provide all outputs) 
% tolerance: 1 (vary accurate tolerance), 2 (less accurate tolerance - for
% use in bound finding)
% NucFuel: 'UO2' for uranium oxide (near term), 'UW' for uranium tunsten
% (exotic)
% RecupMatl: 'IN' for Inconel, 'SS' for stainless steel, 
%   for recuperator far term exploration, use 'U#' -
%   uninsulated, # of units, 'I#' -insulated, # of units
%   (all units are Inconel for these cases)

% Outputs:
% minMass: lowest possible total system mass for system with desired
% power output and radiator area

% find minimum UA which gives desired power output
[ UA_min,m_dot_original ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);


if isnan(UA_min) || isnan(m_dot_original)
    minMass = NaN;
    UA = Inf;
    UA_min = Inf;
    mass_reactor = inf;
    mass_recuperator = inf;
    mass_radiator = inf;
    m_dot = inf;
else
    
    
    %%%%%%%%%%%%%% find bounds for mass minimization %%%%%%%%%%%%%%%%%%
    UA_max = UA_min*2;
    UA_min = UA_min + 1e-8;
    options1 = optimset('TolX',1e-5);
    a = 1;
    loopcount = 1; 
    
    while a ==1
        UA = linspace(UA_min,UA_max,5);
        
        % preallocate space
        mass_total = zeros(1,length(UA));
        m_dotcycle_max = m_dot_original;
        for i = 1:length(UA)
            [ mass_total(i),~,~,~,m_dot_last ] = totalMass( UA(i),desiredPower,p1,T4,PR_c,A_panel,...
                T_amb,fluid,mode,m_dotcycle_max,options1,NucFuel,RecupMatl);
            m_dotcycle_max = m_dot_last;
            if i > 1 && mass_total(i) > mass_total(i-1)
                % mass is getting larger, the solution has
                % already been passed -no need to calculate the other
                % values (starting with the minimum UA, the total mass
                % should start large, reach a minimum, and then go up again
                mass_total(i+1:end) = [];
                break
            end
        end

        [~,inde] = min(mass_total);
        
        if inde == length(UA)
            UA_max = UA(length(UA))*2;
            UA_min = UA(length(UA-1));
        else
            a = 0;
        end
        
        if loopcount > 50 && a ==1
            fprintf(2, 'minRadRecMass: unable to find UA boundaries \n \n');
            UA_max = NaN;
            UA_min = NaN;
            break
        end
        
        loopcount = loopcount + 1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%% end bound find %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % find recuperator conductance for cycle with minimum mass
    if tolerance == 1
        options2 = [];
        [UA,minMass] = fminbnd(@totalMass,UA_min,UA_max,[],desiredPower,p1,T4,PR_c,A_panel,...
        T_amb,fluid,mode,m_dot_original,options2,NucFuel,RecupMatl);
    elseif tolerance == 2
%         options2 = optimset('TolX',0.1);
        % if high accuracy in tolerance is not required, use minimum mass
        % and corresponding UA from bound finding
        UA = UA(inde);
        minMass = mass_total(inde);
    end
    
    
    if check == 2
        [ ~,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = totalMass( UA,desiredPower,p1,T4,PR_c,A_panel,...
            T_amb,fluid,mode,m_dot_original,options2,NucFuel,RecupMatl);
    else
        mass_reactor = inf;
        mass_recuperator = inf;
        mass_radiator = inf;
        m_dot = inf;
    end
end

end

