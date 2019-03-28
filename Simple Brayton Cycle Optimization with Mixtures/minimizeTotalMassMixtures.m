function [ TotalMinMass,UA,UA_min,A_panel,mass_reactor,mass_recuperator,mass_radiator,m_dot,T1,ApanelMin ] = minimizeTotalMassMixtures( desiredPower,p1,T4,PR_c,T_amb,fluid,mode,NucFuel,RecupMatl )
% gives minimum system mass for a cycle with a specified power output

% Inputs:
% desiredpower: specified power for the system [W]
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% NucFuel: 'UO2' for uranium oxide (near term), 'UW' for uranium tunsten
% RecupMatl: 'IN' for Inconel, 'SS' for stainless steel, 
%   for recuperator far term exploration, use 'U#' -
%   uninsulated, # of units, 'I#' -insulated, # of units
%   (all units are Inconel for these cases)


% Outputs:
% minMass: lowest possible total system mass for system with desired
% UA: recuperator conductance for optimum cycle [W/K]
% UA_min: minimum recuperator conductance for optimum radiator panel area
% [W/K]
% A_panel: optimum radiator panel area [m2]
% mass_reactor: reactor mass of optimum cycle [kg]
% mass_recuperator: recuperator mass of optimum cycle [kg]
% mass_radiator: radiator mass of optimum cycle [kg]
% m_dot: mass flow rate of optimum cycle [kg/s]

[ ApanelMin ] = minApanelFind(desiredPower,p1,T4,PR_c,T_amb,fluid,mode);
A_panel_max = ApanelMin + 70;
steps = 20;
stop = 0;

while stop == 0
    A_panel = ApanelMin:2:A_panel_max
    minMass = zeros(1,steps);
    for i = 1:length(A_panel)
        [minMass(i),~,~,~,~,~,...
            ~] = minRadRecMass( A_panel(i),desiredPower,p1,T4,PR_c,T_amb,...
            fluid,mode,2,2,NucFuel,RecupMatl )
        if i > 1 && minMass(i) > minMass(i-1)
            % if mass is getting larger with larger Apanel, the solution has
            % already been passed -no need to calculate the other values
            minMass(i+1:end) = [];
            A_panel_max = A_panel(i);
            stop = 1;
            break
        end
        
    end
    [~,inde] = min(minMass);
    if inde == length(A_panel)
        A_panel_max = 2*A_panel_max;
    end
end
ApanelMin
A_panel_max
% options = optimset('TolX', 1e-3);
[A_panel,TotalMinMass] = fminbnd(@minRadRecMass,ApanelMin,A_panel_max,[],desiredPower,p1,T4,PR_c,...
    T_amb,fluid,mode,1,1,NucFuel,RecupMatl);

[ ~,UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = minRadRecMass( A_panel,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,2,1,NucFuel,RecupMatl );


[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,0);
end

