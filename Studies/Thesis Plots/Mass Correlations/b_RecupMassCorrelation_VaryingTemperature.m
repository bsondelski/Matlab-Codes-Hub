% plots recuperator mass at UA = 4 kW/K and 15 kW/K against hot side inlet
% temperature. Results are compared to data points from Creare

set(0,'defaultAxesFontSize',14)

%%%%%%%%%%%%%%%%%% plot for inconel values %%%%%%%%%%%%%%%%%%%%%%%%%%
p2 = 18000;
p5 = 9229.3;
T5 = linspace(700,1050);
UA = 15000;
Material = 'IN';
TR1 = 550 + 273.15;
TR2 = 650 + 273.15;
TR3 = 750 + 273.15;
mode = 2;
m_dot = 0.7922;
for i = 1:length(T5)
   
    [ mass_spline(i) ] = RecuperatorMass( p2,T5(i),p5,Material,UA,'CO2',mode,m_dot );

end
creareTemp = [550, 650, 750] + 273.15;
%%%%%%%%% original values %%%%%%%%%
% crearemass = [39, 56.5, 118.6];
% updated values 4/7/2019
crearemass = [4.99, 7.39, 18.75];
plot(T5,mass_spline,'k')
hold on
scatter(creareTemp, crearemass,'k','filled')

UA = 4000;
for i = 1:length(T5)
    
   
    [ mass_spline(i) ] = RecuperatorMass( p2,T5(i),p5,Material,UA,'CO2',mode,m_dot );

end
creareTemp = [550, 650, 750] + 273.15;
%%%%%%%%% original values %%%%%%%%%
% crearemass = [16.62, 24.7, 55.1];
% updated values 4/7/2019
crearemass = [2.02, 3.61, 5.78];
plot(T5,mass_spline,'--k')
scatter(creareTemp, crearemass,'k')
xlabel('Temperature at Recuperator Hot Side Inlet [K]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
legend({'UA = 15 [kW/K] Using max. allowable stress','UA = 15 [kW/K] Creare data','UA = 4 [kW/K] Using max. allowable stress','UA = 4 [kW/K] Creare data'},'location','northwest','fontsize',11)
grid on
xlim([700 1050])


%%%%%%%%%%%%%%%%%% plot for stainless values %%%%%%%%%%%%%%%%%%%%%%%%%%
T5 = linspace(700,1050);
UA = 15000;
Material = 'SF';
for i = 1:length(T5)
   
    [ mass_spline(i) ] = RecuperatorMass( p2,T5(i),p5,Material,UA,'CO2',mode,m_dot );

end
%%%%%%%%% original values %%%%%%%%%
% creareTemp = [550, 650] + 273.15;
% crearemass = [96, 129.1];
% updated values 4/7/2019
creareTemp = 550 + 273.15;
crearemass = 15.8;
figure
plot(T5,mass_spline,'k')
hold on
scatter(creareTemp, crearemass,'k','filled')

UA = 4000;
for i = 1:length(T5)
   
    [ mass_spline(i) ] = RecuperatorMass( p2,T5(i),p5,Material,UA,'CO2',mode,m_dot );

end
%%%%%%%%% original values %%%%%%%%%
% creareTemp = [550, 650] + 273.15;
% crearemass = [42.9, 49.5];
% updated values 4/7/2019
creareTemp = 550 + 273.15;
crearemass = 5.81;
plot(T5,mass_spline,'--k')
scatter(creareTemp, crearemass,'k')

xlabel('Temperature at Recuperator Hot Side Inlet [K]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
legend({'UA = 15 [kW/K] Using max. allowable stress','UA = 15 [kW/K] Creare data','UA = 4 [kW/K] Using max. allowable stress','UA = 4 [kW/K] Creare data'},'location','northwest','fontsize',11)
grid on
xlim([700 1050])

