% file to test setup of Matlab Codes for Brayton Cycle code using fluid 
% property tables for mixtures

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instructions:

% 1. load the "CO2H2O5050" (molar fraction of 50/50 H2O/CO2) fluid file
%    under 'Properties Functions\MixtureProperties' 
% 2. be sure the entire 'Matlab Codes' folder and its sub folders are in 
%       your matlab 'set path' -also be sure
%       pressureDrops = 0 in 'Simple Brayton Cycle\findPressures' code line 
%       20
% 3. run this script
% 4. command window outputs should be:
%    net_power = 4.0000e+04
%    cyc_efficiency = 0.2543    0.5353
%    D_T = 0.0124
%    D_c = 0.0116
%    Ma_T = 0.7201
%    Ma_c = 0.7685
%    Anozzle = 9.8941e-06
%    q_reactor = 1.5730e+05
%    q_rad = -1.1730e+05
%    T1 = 577.5017
%    Power_T = 1.0404e+05
%    Power_c = 6.4038e+04
%    HEXeffect = 0.9943
%    energy = 0.3924
%    p1 = 25000
%    T2 = 673.4623
%    p2 = 50000
%    T3 = 945.5054
%    p3 = 50000
%    T4 = 1100
%    p4 = 50000
%    T5 = 980.5542
%    p5 = 25000
%    T6 = 675.0674
%    p6 = 25000
%    A_panel = 22.5079
%    Vratio = 0.6698

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% sets inputs
desiredPower = 40000;
p1 = 25000;
T4 = 1100;
PR_c = 2;
T_amb = 200;
NucFuel = 'UO2';
RecupMatl = 'IN';
fluid = {'CO2','H2O','50','50'};

UA = 23716.2304986107;
m_dot = 0.585847070837015;
A_panel = 22.5078967863656;



% run Brayton Cycle code
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,0)
