% file to test setup of Matlab Codes for Brayton Cycle code using fluid
% property tables for pure CO2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instructions:

% 1. load the "CO2H2O10" (pure CO2) fluid file under 
%    'Properties Functions\MixtureProperties' 
% 2. be sure the entire 'Matlab Codes' folder and its sub folders are in 
%       your matlab 'set path' -also be sure
%       pressureDrops = 0 in 'Simple Brayton Cycle\findPressures' code line 
%       20
% 3. run this script
% 4. command window outputs should be:
%    net_power = 4.0000e+04
%    cyc_efficiency = 0.2908    0.5616
%    D_T = 0.0136
%    D_c = 0.0130
%    Ma_T = 0.7223
%    Ma_c = 0.7340
%    Anozzle = 1.2162e-05
%    q_reactor = 1.3756e+05
%    q_rad = -9.7557e+04
%    T1 = 530.4098
%    Power_T = 1.1210e+05
%    Power_c = 7.2097e+04
%    HEXeffect = 0.9901
%    energy = -0.0089
%    p1 = 25000
%    T2 = 617.5348
%    p2 = 50000
%    T3 = 974.8022
%    p3 = 50000
%    T4 = 1100
%    p4 = 50000
%    T5 = 995.0503
%    p5 = 25000
%    T6 = 621.2531
%    p6 = 25000
%    A_panel = 26.6442
%    Vratio = 0.6728

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% sets inputs
desiredPower = 40000;
p1 = 25000;
T4 = 1100;
PR_c = 2;
T_amb = 200;
NucFuel = 'UO2';
RecupMatl = 'IN';
fluid = 'CO2';

UA = 34651.8569736933;
m_dot = 0.833870185618432;
A_panel = 26.6441516760403;



% run Brayton Cycle code
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,0)

