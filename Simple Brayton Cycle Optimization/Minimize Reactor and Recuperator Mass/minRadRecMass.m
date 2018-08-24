function [minMass,UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot] = minRadRecMass( A_panel,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,check,tolerance )
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

% Outputs:
% minMass: lowest possible total system mass for system with desired
% power output and radiator area

% find minimum UA which gives desired power output
[ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);


if UA_min == Inf || m_dotcycle_max == Inf
    minMass = NaN;
    UA = Inf;
    UA_min = Inf;
    mass_reactor = inf;
    mass_recuperator = inf;
    mass_radiator = inf;
    m_dot = inf;
else
    
    
    % find bounds for mass minimization
    UA_max = UA_min*2;
    UA_min = UA_min + 1e-8;
    options1 = optimset('TolX',1e-5);
    a = 1;
    loopcount = 1; 
    
    while a ==1
        UA = linspace(UA_min,UA_max,5);
        
        % preallocate space
        mass_total = zeros(1,length(UA));
        
        for i = 1:length(UA)
            [ mass_total(i),~,~,~,~ ] = totalMass( UA(i),desiredPower,p1,T4,PR_c,A_panel,...
                T_amb,fluid,mode,m_dotcycle_max,options1);
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
        
        if loopcount > 50 && a ==1
            fprintf(2, 'minRadRecMass: unable to find UA boundaries \n \n');
            UA_max = NaN;
            UA_min = NaN;
            break
        end
        
        loopcount = loopcount + 1;
    end
    
    
    
    
    
    
    % find recuperator conductance for cycle with minimum mass
    if tolerance == 1
        options2 = [];
    elseif tolerance == 2
        options2 = optimset('TolX',0.1);
    end
    
    options3 = [];%optimset('TolX',1e-2); %
    [UA,minMass] = fminbnd(@totalMass,UA_min,UA_max,options3,desiredPower,p1,T4,PR_c,A_panel,...
        T_amb,fluid,mode,m_dotcycle_max,options2);
    
    if check == 2
        [ ~,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = totalMass( UA,desiredPower,p1,T4,PR_c,A_panel,...
            T_amb,fluid,mode,m_dotcycle_max,options2);
    else
        mass_reactor = inf;
        mass_recuperator = inf;
        mass_radiator = inf;
        m_dot = inf;
    end
end

end

