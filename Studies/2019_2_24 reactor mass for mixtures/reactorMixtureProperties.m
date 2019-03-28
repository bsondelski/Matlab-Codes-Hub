filename = 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Reactor\sCO2_reactor\data\UO2_CO2_core_radii.txt';
Co2Data = csvread(filename,1,0);
filename2 = 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Reactor\sCO2_reactor\data\UO2_H2O_core_radii.txt';
H2oData = csvread(filename2,1,0);

H2oFraction = 0.05:0.05:0.95;

for i = 1:length(H2oFraction)
   Co2Fraction = 1 - H2oFraction(i);
   dataName =  strcat('CO2','H2O',num2str(Co2Fraction*100),num2str(H2oFraction(i)*100));
   crit_radius = Co2Data(:,2).*Co2Fraction + H2oData(:,2).*H2oFraction(i);
   fuel_frac = Co2Data(:,1);
   T = table(fuel_frac,crit_radius);
   
   filename3 = strcat('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\2019_2_24 reactor mass for mixtures\UO2_',num2str(dataName),'_core_radii.txt');
   writetable(T,filename3)
    
    
end


% sheet = 2;
% filename4 = 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\H2O Information\GettingProperties\reactor properties.xlsx';
% Data = xlsread(filename4,sheet,'A2:F304');
% filename5 = 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\2019_2_24 reactor mass for mixtures\CO2H2O955.txt'
% dlmwrite(filename5,Data,'delimiter','\t','newline','pc')
% 
% T = table(Data);
% writetable(T,filename5,'Delimiter','\t',