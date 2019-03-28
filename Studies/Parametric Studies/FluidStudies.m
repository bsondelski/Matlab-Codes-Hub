
desiredPower = 40000;
p1 = 25000;
T4 = 1100;
PR_c = 2;
T_amb = 200;
NucFuel = 'UO2';
RecupMatl = 'IN';

H2O = 0:5:100;
CO2 = 100 - H2O;
H2O(end) = 1;
CO2(1) = 1;

for i = 13%:length(CO2)
%     try
    fluid4file = strcat('CO2','H2O',num2str(CO2(i)),num2str(H2O(i)));
    fluid = {'CO2','WATER',num2str(CO2(i)),num2str(H2O(i))};
    fluidfile = strcat('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\H2O Information\Properties\',fluid4file);
    load(fluidfile)
    if i == length(CO2)
        fluid = 'WATER';
    elseif i == 1
        fluid = 'CO2';
    end
    
    fluid
    
    [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),...
        mass_radiator(i),m_dot(i),T1(i),ApanelMin(i) ] = minimizeTotalMassMixtures(desiredPower,...
        p1,T4,PR_c,T_amb,fluid,mode,NucFuel,RecupMatl)
%     catch
%         TotalMinMass(i) = NaN;
%         UA(i) = NaN;
%         A_panel(i) = NaN;
%         mass_reactor(i) = NaN;
%         mass_recuperator(i) = NaN;
%         mass_radiator(i) = NaN;
%         m_dot(i) = NaN;
%         T1(i)  = NaN;
%         ApanelMin(i)  = NaN;
%         
%     end

    
end



