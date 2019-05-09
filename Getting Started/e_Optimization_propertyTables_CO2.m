% file to test setup of Matlab Codes for cycle optimization using fluid
% property tables for pure CO2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instructions:

% 1. be sure you have python installed
% 2. in the reactor mass code, modify lines 22 and 23 with your computer 
%    name and the location of the python code
% 3. be sure the entire 'Matlab Codes' folder and its sub folders are in 
%       your matlab 'set path' -also be sure
%       pressureDrops = 0 in 'Simple Brayton Cycle\findPressures' code line 
%       20
% 4. be sure your file directory path in matlab is set to 'Matlab
%    Codes\Reactor\sCO2_reactor\optimization'
% 5. load the "CO2H2O10" (pure CO2) fluid file under 
%    'Properties Functions\MixtureProperties' 
% 6. run this script (run time is approximately 30 minutes)
% 7. command window outputs should be:
%    TotalMinMass = 362.3491
%    UA = 3.4429e+04
%    UA_min = 2.6263e+04
%    A_panel = 26.6659
%    mass_reactor = 155.8281
%    mass_recuperator = 26.5260
%    mass_radiator = 179.9950
%    m_dot = 0.8333
%    T1 = 530.2659
%    ApanelMin = 25.7440
%    flag = 5


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

% run Optimization code
[ TotalMinMass,UA,UA_min,A_panel,mass_reactor,mass_recuperator,...
    mass_radiator,m_dot,T1,ApanelMin,flag ]...
    = minimizeTotalMassMixtures( desiredPower,p1,T4,PR_c,T_amb,fluid,...
    mode,NucFuel,RecupMatl )

