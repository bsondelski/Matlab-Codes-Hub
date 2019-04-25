function [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,q_reactor,...
    q_rad,T1,m_dotcycle,T3,p3,T4,p4,T5,p5,T2,p2,T6,p6] =...
    SpecifiedPower2(power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,m_dotlast,options)

% finding the mass flow rate required for the specified power output of the
% system

% Inputs:
% power: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% UA: conductance of recuperator [W/K]
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% m_dot_last: maximum m_dot used to search - found from smaller UA's
% options: tolerance on search for matching desired output power

% outputs:
% net_power: net power output from the cycle
% cyc_efficiency: total cycle efficiency
% D_T: turbine diameter
% D_c: compressor diameter
% Ma_T: Turbine outlet Mach number
% Ma_c: compressor outlet Mach number
% Anozzle: turbine nozzle area
% q_reactor: heat input to the reactor [W]
% q_rad: heat rejected by the radiator [W]
% T1: the temperatue at the inlet of the compressor
% Power_T: power output of the turbine
% Power_c: power intake of the compressor
% HEXeffect: effectiveness of the heat exchanger
% energy: check to see if energy is conserved (should be zero)
% m_dot: the mass flow in the cycle [kg/s]
% T3, p3, T4, p4: temperatures and pressures around the reactor [K] and
% [kPa]


% First (and maximum possible) mass flow rate is equivalent to last
% input mass flow rate. Since last mass flow rate is from lower UA,
% next mass flow rate will be lower.
a = 1;
i = 1;
m_dot(i) = m_dotlast;


[net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = ...
    BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);

net_power(i) = round(net_power(i));
if net_power(1) == power
    m_dotcycle = m_dotlast;
    a = 2;
    
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,~,q_reactor,...
        q_rad,T1,~,~,~,~,~,T2,p2,T3,p3,T4,p4,...
        T5,p5,T6,p6,~,~] = BraytonCycle(m_dotcycle,p1,T4,...
        PR_c,UA,A_panel,T_amb,fluid,mode,0);
else
    
end

% find range of m_dot where desired power is given by stepping down m_dot
%%%% m_dot bound find %%%
d_m_dot = 0.1;
while a == 1
    i = i+1;
    m_dot(i) = m_dot(i-1)-d_m_dot;
    [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] =...
        BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    if isnan(net_power(i))
        % the m_dot decrease was too large, cut it in half
        d_m_dot = d_m_dot/2;
        fprintf(2, 'SpecifiedPower2: dmdot changing!! \n');
        i = i-1; % reset count to start the loop over at the last working m_dot value
    else
        if net_power(i) < power
            m_dotmax = m_dot(i-1);
            m_dotmin = m_dot(i);
            a = 0;
        else
        end
    end
    
    if a == 1 && d_m_dot < 1e-8
        % if UA is too high that you can't find a working m_dot, this
        % likely means that the cycle that would be the solution would have 
        % too low of T1
        fprintf(2, 'SpecifiedPower2: issue with m_dot finding \n');
        m_dotmin = NaN;
        m_dotmax = NaN;
        break
    end
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find exact m_dot and all quantities resulting for desired power
if a == 0
    m_dotcycle = fzero(@specifiedPowerError,[m_dotmin,m_dotmax],options,...
        power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,~,q_reactor,...
        q_rad,T1,~,~,~,~,~,T2,p2,T3,p3,T4,p4,...
        T5,p5,T6,p6,~,~] = BraytonCycle(m_dotcycle,p1,T4,...
        PR_c,UA,A_panel,T_amb,fluid,mode,0);
end
    
if a == 1
    m_dotcycle = NaN;
    net_power = NaN;
    cyc_efficiency = NaN;
    D_T = NaN;
    D_c = NaN;
    Ma_T = NaN;
    Ma_c = NaN;
    q_reactor = NaN;
    q_rad = NaN;
    T1 = NaN;
    T3 = NaN;
    p3 = NaN;
    T4 = NaN;
    p4 = NaN;
    T5 = NaN;
    p5 = NaN;
    T6 = NaN;
    p6 = NaN;
    T2 = NaN;
    p2 = NaN;
end


    
end

