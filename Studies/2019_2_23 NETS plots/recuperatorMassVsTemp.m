% plot mass vs hot side inlet temperature for Inconel, near term ss, and
% far term ss
set(0,'defaultAxesFontSize',14)


p2 = 18000;
p5 = 9229.3;
T5 = linspace(700,1050);
UA = 15000;
mode = 2;


Material = 'SS';
for i = 1:length(T5)
    [ massStainless(i) ] = RecuperatorMass( p2,T5(i),p5,Material,UA,'CO2',mode );
end
plot(T5(1:36),massStainless(1:36),'--k','linewidth',1.5);
hold on
plot(T5(36:end),massStainless(36:end),':k','linewidth',1.5);


Material = 'IN';
for i = 1:length(T5)
    [ massInconel(i) ] = RecuperatorMass( p2,T5(i),p5,Material,UA,'CO2',mode );
end
plot(T5,massInconel,'k');


xlabel('Temperature at Recuperator Hot Side Inlet [K]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
% legend({'UA = 15 [kW/K] Cubic interpolation - max allow stress','UA = 15 [kW/K] Industry partner data','UA = 4 [kW/K] Cubic interpolation - max allow stress','UA = 4 [kW/K] Industry partner data'},'location','northwest','fontsize',11)
legend({'Stainless Steel Near Term','Stainless Steel Far Term','Inconel'},'fontsize',16,'location','north')
title('UA = 15 kW/K','fontsize',18)
grid on
xlim([700 1050])