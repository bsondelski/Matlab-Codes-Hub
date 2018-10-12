function [p2,p3,p4,p6,p5,PR_T] = findPressures(p1,PR_c)
% Find pressures at all states of the cycle

% inputs:
% p1: pressure at compressor inlet/radiator outlet
% PR_c: the pressure ratio of the compressor

% outputs:
% p2: the pressure at the compressor outlet
% p3: the pressure at the recuperator cold side outlet
% p4: the pressure at the reactor outlet
% p6: the pressure at the radiator inlet
% p5: the pressure at the recuperator hot side inlet
% PR_T: the pressure ratio for the turbine

% % pressure drop values
% ploss_HEX_C = 0.0052;     % pressure drop on cold side of recuperator
% ploss_HEX_H = 0.0150;     % pressure drop on hot side of recuperator
% ploss_reactor = 0.0270;   % pressure drop in reactor
% ploss_radiator = 0.0100;  % pressure drop in radiator
% 
% % calculate pressures
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = p2-p2*ploss_HEX_C;   % pressure at recuperator cold side outlet
% p4 = p3-p3*ploss_reactor; % pressure at reactor outlet
% 
% % back calculate pressures 
% p6 = p1/(1-ploss_radiator);   % pressure at radiator inlet
% p5 = p6/(1-ploss_HEX_H);      % pressure at recuperatpr hot side inlet
% 
% PR_T = p4/p5;                 % the pressure ratio in the turbine

% no pressure drops
p2 = PR_c*p1;             % pressure at compressor outlet
p3 = p2;
p4 = p2;
p5 = p1;
p6 = p1;
PR_T = PR_c;


end

