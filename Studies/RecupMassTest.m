T5 = linspace(700,1100);
UA = 20000;

TR1 = 550 + 273.15;
TR2 = 650 + 273.15;
TR3 = 750 + 273.15;


for i = 1:length(T5)
    
    
    if T5(i) < TR1
        mass_recuperator(i) = 0.002034545*UA + 8.481818; %convert to kW/K
    elseif T5(i) < TR2
        mass_recuperator1 = 0.002034545*UA + 8.481818; %convert to kW/K
        mass_recuperator2 = 0.002890909*UA + 13.13636; %convert to kW/K
        
        mass_recuperator(i) = (mass_recuperator2 - mass_recuperator1)/(TR2 - TR1)*(T5(i) - TR1) + mass_recuperator1;
        
    elseif T5(i) < TR3
        mass_recuperator1 = 0.002890909*UA + 13.13636; %convert to kW/K
        mass_recuperator2 = 0.005772727*UA + 32.00909; %convert to kW/K
        
        mass_recuperator(i) = (mass_recuperator2 - mass_recuperator1)/(TR3 - TR2)*(T5(i) - TR2) + mass_recuperator1;
    else
        mass_recuperator(i) = 0.005772727*UA + 32.00909; %convert to kW/K
    end
    
end

plot(T5,mass_recuperator)