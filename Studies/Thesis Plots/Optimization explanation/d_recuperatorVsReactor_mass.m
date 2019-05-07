% figure 1 - combined mass vs reactor heat output for one radiator panel area
% figure 2 - Ts diagram for cycle with a large recuperator 
% figure 3 - Ts diagram for cycle with a large reactor 
clear

set(0,'defaultAxesFontSize',14)

p1=9000;
T4=900;
PR_c=2;
A_panel=175;
T_amb=200;
fluid='CO2';
mode=2;
desiredPower = 40000;
NucFuel = 'UO2';

[ UA_min,m_dotcycle_max ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);
UA=UA_min:200:UA_min+15000;
m_dotlast(1) = m_dotcycle_max;

[net_power,~,~,~,~,~,~,q_reactor(1),...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,T5(1),...
    ~,~,~,~,~] = BraytonCycle(m_dotcycle_max,p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0);

options = [];
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor(j+1),...
        ~,~,m_dotlast(j+1),T3(j+1),p3,T4out(j+1),p4,T5(j+1),p5,~,p2,~,~] =...
        SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast(j),options);
    
    mass_reactor(j) = ReactorMass(q_reactor(j+1),m_dotlast(j+1),p3,p4,T3(j+1),T4out(j+1),fluid,NucFuel);
    mass_recuperator(j) = RecuperatorMass( p2,T5(j),p5,'SN',UA(j),fluid,mode,m_dotlast(j+1) );
end
A_panel_i = ones(1,length(mass_reactor))*A_panel;
mass_radiator = A_panel_i*6.75;
mass_comb = mass_reactor + mass_recuperator + mass_radiator;

figure(1)
plot(q_reactor(5:end)/1000,mass_comb(4:end),'k')
hold on
[~,I] = min(mass_comb);
scatter(q_reactor(I)/1000,mass_comb(I),'k','filled');
text(q_reactor(I)/1000 + 1,mass_comb(I) - 1,'A','fontsize',14)
xlabel('Reactor Heat Output [kW]','fontsize',18)
ylabel('Combined Mass [kg]','fontsize',18)
grid on
ylim([1305 1337])
xlim([100 210])

% pause
scatter(q_reactor(5)/1000,mass_comb(4),'k','filled');
scatter(q_reactor(end)/1000,mass_comb(end),'k','filled');
text(q_reactor(5)/1000 + 2,mass_comb(4) + 1,'2','fontsize',14)
text(q_reactor(end)/1000 + 2,mass_comb(end) + 1,'1','fontsize',14)

[~,efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotlast(end),p1,T4,PR_c,UA(end),...
    A_panel,T_amb,fluid,mode,1)
ylim([240 950])

[~,efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotlast(5),p1,T4,PR_c,UA(4),...
    A_panel,T_amb,fluid,mode,1)
ylim([240 950])





