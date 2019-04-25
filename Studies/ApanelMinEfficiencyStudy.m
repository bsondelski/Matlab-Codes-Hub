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
fluid = 'CO2';
mode = 2;

for i = 1:16
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
    options = optimset('TolX',1e-5);
    A_panel = 26;%ApanelMin(i);
    [ UA_min_original,m_dotcycle_max ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);
UA = 35000;
[ mass_total,mass_reactor,mass_recuperator,mass_radiator,m_dot ] = totalMass( UA,desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode,m_dotcycle_max,options,NucFuel,RecupMatl);


[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1(i),Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,~,p4,T5,...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,0);
    
  efficiency_cycle(i) = cyc_efficiency(1);
    
end
scatter(H2O(1:14),efficiency_cycle(1:14),'k')
ylabel('Cycle Efficiency')
xlabel('Percent H2O')