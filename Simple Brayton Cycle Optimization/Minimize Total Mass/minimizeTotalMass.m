function [ TotalMinMass,UA,UA_min,A_panel,mass_reactor,mass_recuperator,mass_radiator ] = minimizeTotalMass( desiredPower,p1,T4,PR_c,T_amb,fluid,mode )
% gives minimum system mass for a cycle with a specified power output

% Inputs:
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% minMass: lowest possible total system mass for system with desired
% power output

tf = strcmp('OXYGEN',fluid);
if tf == 1
    A_panel_min = 50;
    A_panel_max = 100;
else
    A_panel_min = 40;
    A_panel_max = 120;
end



[A_panel,TotalMinMass] = fminbnd(@minRadRecMass,A_panel_min,A_panel_max,[],desiredPower,p1,T4,PR_c,...
    T_amb,fluid,mode,1);

[ ~,UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = minRadRecMass( A_panel,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,2 );

m_dot
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,1)

end

