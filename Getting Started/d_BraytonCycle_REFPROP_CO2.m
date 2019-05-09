% file to test setup of Matlab Codes for Brayton Cycle code using REFPROP
% for pure CO2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instructions:

% 1. Install REFPROP on your computer
% 2. be sure the entire 'Matlab Codes' folder and its sub folders are in 
%       your matlab 'set path' 
% 3. in 'Simple Brayton Cycle\findPressures' code, line 20: set
%    pressureDrops = 1 (turns pressure drops on)
% 4. run this script
% 5. command window outputs should be:
%    net_power = 4.0000e+04
%    cyc_efficiency = 0.2700    0.5003
%    D_T = 0.0251
%    D_c = 0.0237
%    Ma_T = 0.7040
%    Ma_c = 0.8532
%    Anozzle = 4.2407e-05
%    q_reactor = 1.4814e+05
%    q_rad = -1.0814e+05
%    T1 = 414.2407
%    Power_T = 1.0828e+05
%    Power_c = 6.8276e+04
%    HEXeffect = 0.9838
%    energy = -1.4687e-04
%    p1 = 9000
%    T2 = 489.2499
%    p2 = 18000
%    T3 = 795.8189
%    p3 = 1.7906e+04
%    T4 = 900
%    p4 = 1.7423e+04
%    T5 = 818.3339
%    p5 = 9.2293e+03
%    T6 = 494.6652
%    p6 = 9.0909e+03
%    A_panel = 84.4128
%    Vratio = 0.6761

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% sets inputs
desiredPower = 40000;
p1 = 9000;
T4 = 900;
PR_c = 2;
T_amb = 200;
NucFuel = 'UO2';
RecupMatl = 'SN';
fluid = 'CO2';
mode = 3;           % sets fluid property mode to REFPROP

UA = 29299.0487210445;
m_dot = 1.14469881455373;
A_panel = 84.4127525986819;



% run Brayton Cycle code
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,0)

