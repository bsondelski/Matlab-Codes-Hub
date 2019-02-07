% plot mass vs pressure for Inconel, near term ss, and
% far term ss
set(0,'defaultAxesFontSize',14)


p1 = linspace(9000,20000);
PR_c = 2;

% pressure drop values
ploss_HEX_C = 0.0052;     % pressure drop on cold side of recuperator
ploss_HEX_H = 0.0150;     % pressure drop on hot side of recuperator
ploss_reactor = 0.0270;   % pressure drop in reactor
ploss_radiator = 0.0100;  % pressure drop in radiator

% calculate pressures
p2 = PR_c*p1;             % pressure at compressor outlet
p3 = p2-p2*ploss_HEX_C;   % pressure at recuperator cold side outlet
p4 = p3-p3*ploss_reactor; % pressure at reactor outlet

% back calculate pressures 
p6 = p1/(1-ploss_radiator);   % pressure at radiator inlet
p5 = p6/(1-ploss_HEX_H);      % pressure at recuperatpr hot side inlet




T5 = 900;
UA = 15000;
mode = 2;


Material = 'SS';
for i = 1:length(p2)
    [ massStainless(i) ] = RecuperatorMass( p2(i),T5,p5(i),Material,UA,'CO2',mode );
end
plot(p2/1000,massStainless,'--k','linewidth',1.5);
hold on


Material = 'IN';
for i = 1:length(p2)
    [ massInconel(i) ] = RecuperatorMass( p2(i),T5,p5(i),Material,UA,'CO2',mode );
end
plot(p2/1000,massInconel,'k');


xlabel('Pressure at Compressor Inlet [kPa]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
legend({'Stainless Steel','Inconel'},'fontsize',16,'location','east')
title('UA = 15 kW/K','fontsize',18)
grid on