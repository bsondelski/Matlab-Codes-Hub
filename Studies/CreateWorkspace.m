% create matlab workspace "inputs" to send to CHTC to help solve
% optimization

clear

m_dot = 0.6447;
p1 = 25000;
T4 = 1100;
PR_c = 2;
UA = 8.5362e3;
A_panel = 39.0505;
T_amb = 100;
% fluid = {'CO2','water',[0.9,0.1]};
plot = 0;

% A_panel = 40;
% desiredPower = 40000;
% p1 = 9000;
% T4 = 1100;
% PR_c = 2;
% T_amb = 100;
% fluid = {'CO2','water',[1,0]};
fluid = 'CO2';
mode = 2;

save('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\CHTC files\inputs')