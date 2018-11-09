% to be used for creating plots for recuperator mass correlation

set(0,'defaultAxesFontSize',12)

T5 = linspace(700,1050);
UA = 15000;
Material = 'IN';
TR1 = 550 + 273.15;
TR2 = 650 + 273.15;
TR3 = 750 + 273.15;
for i = 1:length(T5)
%      if T5(i) < TR1
%         mass_recuperator(i) = 0.002034545*UA + 8.481818; %convert to kW/K
%     elseif T5(i) < TR2
%         mass_recuperator1 = 0.002034545*UA + 8.481818; %convert to kW/K
%         mass_recuperator2 = 0.002890909*UA + 13.13636; %convert to kW/K
%         
%         mass_recuperator(i) = (mass_recuperator2 - mass_recuperator1)/(TR2 - TR1)*(T5(i) - TR1) + mass_recuperator1;
%         
%     elseif T5(i) < TR3
%         mass_recuperator1 = 0.002890909*UA + 13.13636; %convert to kW/K
%         mass_recuperator2 = 0.005772727*UA + 32.00909; %convert to kW/K
%         
%         mass_recuperator(i) = (mass_recuperator2 - mass_recuperator1)/(TR3 - TR2)*(T5(i) - TR2) + mass_recuperator1;
%     else
%         mass_recuperator(i) = 0.005772727*UA + 32.00909; %convert to kW/K
%     end
   
    [ mass_spline(i) ] = RecuperatorMass( T5(i),Material,UA );

end
creareTemp = [550, 650, 750] + 273.15;
crearemass = [39, 56.5, 118.6];


plot(T5,mass_spline,'k')
hold on
% plot(T5,mass_recuperator)
scatter(creareTemp, crearemass,'k','filled')

UA = 4000;
for i = 1:length(T5)
    
%     if T5(i) < TR1
%         mass_recuperator(i) = 0.002034545*UA + 8.481818; %convert to kW/K
%     elseif T5(i) < TR2
%         mass_recuperator1 = 0.002034545*UA + 8.481818; %convert to kW/K
%         mass_recuperator2 = 0.002890909*UA + 13.13636; %convert to kW/K
%         
%         mass_recuperator(i) = (mass_recuperator2 - mass_recuperator1)/(TR2 - TR1)*(T5(i) - TR1) + mass_recuperator1;
%         
%     elseif T5(i) < TR3
%         mass_recuperator1 = 0.002890909*UA + 13.13636; %convert to kW/K
%         mass_recuperator2 = 0.005772727*UA + 32.00909; %convert to kW/K
%         
%         mass_recuperator(i) = (mass_recuperator2 - mass_recuperator1)/(TR3 - TR2)*(T5(i) - TR2) + mass_recuperator1;
%     else
%         mass_recuperator(i) = 0.005772727*UA + 32.00909; %convert to kW/K
%     end
    
    [ mass_spline(i) ] = RecuperatorMass( T5(i),Material,UA );

end
creareTemp = [550, 650, 750] + 273.15;
crearemass = [16.62, 24.7, 55.1];

plot(T5,mass_spline,'--k')
% plot(T5,mass_recuperator)
scatter(creareTemp, crearemass,'k')
xlabel('Temperature at Recuperator Hot Side Inlet [K]')
ylabel('Recuperator Mass [kg]')
legend('UA = 15 [kW/K] Cubic interpolation - max allow stress','UA = 15 [kW/K] Creare Data','UA = 4 [kW/K] Cubic interpolation - max allow stress','UA = 4 [kW/K] Creare Data','location','northwest')
% legend('UA = 15 [kW/K] Cubic interpolation - max allow stress','liner interpolation - Creare data','Creare Data','UA = 4 [kW/K] Cubic interpolation - max allow stress','liner interpolation - Creare data','Creare Data','location','northwest')
% title('Inconel')

T5 = linspace(700,1050);
UA = 15000;
Material = 'SS';
for i = 1:length(T5)
   
    [ mass_spline(i) ] = RecuperatorMass( T5(i),Material,UA );

end
creareTemp = [550, 650] + 273.15;
crearemass = [96, 129.1];

figure
plot(T5,mass_spline,'k')
hold on
scatter(creareTemp, crearemass,'k','filled')

UA = 4000;
for i = 1:length(T5)
   
    [ mass_spline(i) ] = RecuperatorMass( T5(i),Material,UA );

end
creareTemp = [550, 650] + 273.15;
crearemass = [42.9, 49.5];

plot(T5,mass_spline,'--k')
scatter(creareTemp, crearemass,'k')

xlabel('Temperature at Recuperator Hot Side Inlet [K]')
ylabel('Recuperator Mass [kg]')
legend('UA = 15 [kW/K] Cubic interpolation - max allow stress','UA = 15 [kW/K] Creare Data','UA = 4 [kW/K] Cubic interpolation - max allow stress','UA = 4 [kW/K] Creare Data','location','northwest')
% title('Stainless Steel')


