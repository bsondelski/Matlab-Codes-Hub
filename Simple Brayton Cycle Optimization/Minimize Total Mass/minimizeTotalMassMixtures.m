function [ TotalMinMass,UA,UA_min,A_panel,mass_reactor,mass_recuperator,mass_radiator,m_dot,T1,ApanelMin,flag ] = minimizeTotalMassMixtures( desiredPower,p1,T4,PR_c,T_amb,fluid,mode,NucFuel,RecupMatl )
% gives minimum system mass for a cycle with a specified power output

% Inputs:
% desiredpower: specified power for the system [W]
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% NucFuel: 'UO2' for uranium oxide (near term), 'UW' for uranium tunsten
% RecupMatl: 'IN' for Inconel, 'SN' for near term stainless steel, 'SF' for
%            far term stainless steel



% Outputs:
% TotalMinMass: lowest possible total system mass for system with desired
% UA: recuperator conductance for optimum cycle [W/K]
% UA_min: minimum recuperator conductance for optimum radiator panel area
% [W/K]
% A_panel: optimum radiator panel area [m2]
% mass_reactor: reactor mass of optimum cycle [kg]
% mass_recuperator: recuperator mass of optimum cycle [kg]
% mass_radiator: radiator mass of optimum cycle [kg]
% m_dot: mass flow rate of optimum cycle [kg/s]
% T1: cycle minimum temperature [K]
% flag: typically, there is a section with smaller radiator panels (1) and a
%       section with larger radiator panels (2) that can achieve the required
%       power output while remaining above the dew point temperature. there
%       is a section in the middle that sometimes dips below the dew point
%       temperature. flag output options are:
%       1 - there is no section 1, 
%       2 - A=Apanelmax in section 1, 
%       3 - Apanel otherwise in section 1, 
%       4 - section 1 exists but section 2 has lower mass, 
%       5 - Tmin did not reach TDewPoint (normal solving), 
%       0 - flag not set

flag = 0;

[ ApanelMin ] = minApanelFind(desiredPower,p1,T4,PR_c,T_amb,fluid,mode);
A_panel_max = ApanelMin + 70;
steps = 20;
T1BelowDewPoint = 0;
stop = 0;

while stop == 0
    A_panel = linspace(ApanelMin,A_panel_max,steps);
    minMass = zeros(1,steps);
    for i = 1:length(A_panel)
        [minMass(i),~,~,~,~,~,...
            ~] = minRadRecMass( A_panel(i),desiredPower,p1,T4,PR_c,T_amb,...
            fluid,mode,2,NucFuel,RecupMatl );
        if i > 1 && minMass(i) > minMass(i-1)
            % if mass is getting larger with larger Apanel, the solution has
            % already been passed -no need to calculate the other values
            minMass(i+1:end) = [];
            A_panel_max = A_panel(i);
            stop = 1;
            break
        elseif isnan(minMass(i))
            T1BelowDewPoint = 1;
            A_panel_max = A_panel(i);
            minMass(i+1:end) = [];
            stop = 1;
            break
        end
        
    end
    [~,inde] = min(minMass);
    if inde == length(A_panel)
        A_panel_max = 2*A_panel_max;
    end
end

if T1BelowDewPoint == 1 && i == 1
    flag = 1;
    % bounds for Apanel where T1 = TDewPoint
    [ApanelMin,A_panel_max] = findApanelBounds(ApanelMin,desiredPower,p1,T4,PR_c,T_amb,...
        fluid,mode,NucFuel,RecupMatl );
    
    % find A_panel where T1 = TDewPoint
    options = optimset('TolX', 1e-4);
    ApanelMin = fzero(@ApanelAtTDewPoint,[ApanelMin,A_panel_max],options,...
        desiredPower,p1,T4,PR_c,T_amb,fluid,mode);
    
    % find maximum A_panel bound
    stop = 0;
    A_panel_max = ApanelMin + 2;
    [minMass_small,~,~,~,~,~,...
        ~] = minRadRecMass( A_panel_max,desiredPower,p1,T4,PR_c,T_amb,...
        fluid,mode,2,NucFuel,RecupMatl );
    while stop == 0
        
        [minMass_large,~,~,~,~,~,...
            ~] = minRadRecMass( A_panel_max,desiredPower,p1,T4,PR_c,T_amb,...
            fluid,mode,2,NucFuel,RecupMatl );
        if minMass_large > minMass_small
            break
        else
            A_panel_max = A_panel_max + 2;
        end
    end
    
    % find minimum mass
    [A_panel,TotalMinMass] = fminbnd(@minRadRecMass,ApanelMin,A_panel_max,[],desiredPower,p1,T4,PR_c,...
        T_amb,fluid,mode,1,NucFuel,RecupMatl);
        
elseif T1BelowDewPoint == 1
    % find minimum mass with both large and small A_panels and then compare
    % and take absolute minimum (T1 < TDewPoint at intermediate A_panel
    % sizes)
    
    %%%%%%%%%%%%%%%%%%%%%%%% smaller A_panels %%%%%%%%%%%%%%%%%%%%%%%%
    % find maximum A_panel where T1 = TDewPoint
    options = optimset('TolX', 1e-4);
    A_panel_max_small = fzero(@ApanelAtTDewPoint,[ApanelMin,A_panel_max],options,...
        desiredPower,p1,T4,PR_c,T_amb,fluid,mode);
    
    % calculate minimum mass with small A_panels
    [A_panel_small,TotalMinMass_small] = fminbnd(@minRadRecMass,ApanelMin,A_panel_max_small,[],desiredPower,p1,T4,PR_c,...
        T_amb,fluid,mode,1,NucFuel,RecupMatl); 
    
    if A_panel_small == A_panel_max_small
        flag = 2;
    else
        flag = 3;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%% larger A_panels %%%%%%%%%%%%%%%%%%%%%%%%
    % bounds for Apanel where T1 = TDewPoint
    [A_panel_min_large,A_panel_max_large] = findApanelBounds(A_panel_max,desiredPower,p1,T4,PR_c,T_amb,...
        fluid,mode,NucFuel,RecupMatl );
    
    % find A_panel where T1 = TDewPoint
    A_panel_min_large = fzero(@ApanelAtTDewPoint,[A_panel_min_large,A_panel_max_large],options,...
        desiredPower,p1,T4,PR_c,T_amb,fluid,mode);
    
    % if fzero goes slightly to the side where T1 < TDewPoint since bound
    % finding tolerance was set to 1e-4
    A_panel_min_large = A_panel_min_large + 0.01;
    
    % check if  mass at large A_panel minimum bound is > small panel optimum
    [minMass_check,~,~,~,~,~,...
        ~] = minRadRecMass( A_panel_min_large,desiredPower,p1,T4,PR_c,T_amb,...
        fluid,mode,2,NucFuel,RecupMatl );
    
    if minMass_check > TotalMinMass_small
        A_panel = A_panel_small;
        TotalMinMass = TotalMinMass_small;
    else
        flag = 4;
        % minimize mass in large A_panel range
        
        % find maximum A_panel
        stop = 0;
        A_panel_max_large = A_panel_min_large*1.2;
        [minMass_small,~,~,~,~,~,...
            ~] = minRadRecMass( A_panel_max_large,desiredPower,p1,T4,PR_c,T_amb,...
            fluid,mode,2,NucFuel,RecupMatl );
        while stop == 0
            
            [minMass_large,~,~,~,~,~,...
                ~] = minRadRecMass( A_panel_max_large,desiredPower,p1,T4,PR_c,T_amb,...
                fluid,mode,2,NucFuel,RecupMatl );
            if minMass_large > minMass_small
                break
            else
                A_panel_max_large = A_panel_max_large*1.2;
            end
        end
        
        % calculate minimum mass with large A_panels
        [A_panel_large,TotalMinMass_large] = fminbnd(@minRadRecMass,A_panel_max_large,A_panel_max_small,[],desiredPower,p1,T4,PR_c,...
            T_amb,fluid,mode,1,NucFuel,RecupMatl);
        
        %%%%%%%%%%%%%%%%%%%%% compare Apanel's %%%%%%%%%%%%%%%%%%%%%%%%
        if TotalMinMass_small < TotalMinMass_large
            A_panel = A_panel_small;
            TotalMinMass = TotalMinMass_small;
        else
            A_panel = A_panel_large;
            TotalMinMass = TotalMinMass_large;
        end
    end
    
    
 
else
    % normal solving between min/max bounds
    flag = 5;
    options = optimset('TolX', 1e-3);
    [A_panel,TotalMinMass] = fminbnd(@minRadRecMass,ApanelMin,A_panel_max,options,desiredPower,p1,T4,PR_c,...
        T_amb,fluid,mode,1,NucFuel,RecupMatl);
        % note: ApanelMin is left at minimum Apanel becuase if it is increased,
        % when minMass(i) > minMass(i-1), then the minimum could be between
        % minMass(i-1) and minMass(i-2) 
end

       

[ ~,UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = minRadRecMass( A_panel,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,1,NucFuel,RecupMatl );


[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,0);









    function [T1_error] = ApanelAtTDewPoint (Apanel_maxValidGuess,desiredPower,p1,T4,PR_c,...
            T_amb,fluid,mode)
        % Find Apanel where T1 = TDewPoint
        % find minimum UA - T1 is highest at this UA
        [ UA_min_fcn,m_dot_original ] = minimumUA(desiredPower,p1,T4,PR_c,Apanel_maxValidGuess,...
            T_amb,fluid,mode);
        
        % set dew point temperature and T1 at minimum UA (maximum T1)
        [~,~,~,~,~,~,~,~,...
            ~,T1_max,~,~,~,~,~,~,~,~,~,~,~,~,...
            ~,~,~,~,~] = BraytonCycle(m_dot_original,p1,T4,PR_c,UA_min_fcn,...
            Apanel_maxValidGuess,T_amb,fluid,mode,0);
        
        % find dew point temperature
        modesize = size(mode);
        if mode == 2
            TDewPoint = 304.25; % [K]
        elseif mode == 3
            TDewPoint = refpropm('T','C',0,' ',0,fluid);
        elseif modesize(1) > 1
            TDewPoint = mode(1,91);
        end
        
        T1_error = T1_max-TDewPoint;
    end













    function [A_panel_min,A_panel_max_fcn] = findApanelBounds(ApanelMin,desiredPower,p1,T4,PR_c,T_amb,...
            fluid,mode,NucFuel,RecupMatl )
        % find bounds for minimum Apanel where T1 > TDewPoint on upper end of Apanel
        % values - ApanelMin must provide NaN for minMass
        
        A_panel_max_fcn = ApanelMin + 70;
        steps_fcn = 20;
        stop_fcn = 0;
        
        while stop_fcn == 0
            A_panel_fcn = linspace(ApanelMin,A_panel_max_fcn,steps_fcn);
            minMass_fcn = zeros(1,steps_fcn);
            for j = 1:length(A_panel_fcn)
                [minMass_fcn(j),~,~,~,~,~,...
                    ~] = minRadRecMass( A_panel_fcn(j),desiredPower,p1,T4,PR_c,T_amb,...
                    fluid,mode,2,NucFuel,RecupMatl );
                if isnan(minMass_fcn(j)) == false
                    % Apanel where T1 = TDewPoint has been passed
                    A_panel_min = A_panel_fcn(j-2);
                    A_panel_max_fcn = A_panel_fcn(j);
                    stop_fcn = 1;
                    break
                end
                
            end
            if stop_fcn == 0
                A_panel_max_fcn = 2*A_panel_max_fcn;
            end
            if A_panel_max_fcn > 200
                disp('error: could not find Apanel where T1 > TDewPoint')
                break
            end
        end
    end

end

