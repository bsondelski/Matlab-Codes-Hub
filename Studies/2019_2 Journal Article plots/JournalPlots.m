p1=9000;
T4=900;
PR_c=2;
% UA=10000;
% A_panel=175;
A_panel=84.41;
T_amb=200;
fluid='CO2';
mode=2;
desiredPower = 40000;
NucFuel = 'UO2';

[ UA_min,m_dotcycle_max ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);
% UA_min = UA_min + 400;
UA_min = UA_min;
UA=UA_min:500:UA_min+30000; % was 2022.3
m_dotlast(1) = m_dotcycle_max;

[net_power,~,~,~,~,~,~,q_reactor(1),...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,T5(1),...
    ~,~,~,~,~] = BraytonCycle(m_dotcycle_max,p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0);

options = [];
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor(j+1),...
        ~,~,m_dotlast(j+1),T3(j+1),p3,T4out(j+1),p4,T5(j+1),p5,T2,p2,~,~] =...
        SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast(j),options);
    mass_reactor(j) = ReactorMass(q_reactor(j+1),m_dotlast(j+1),p3,p4,T3(j+1),T4out(j+1),fluid,NucFuel);
%     mass_recuperator(j) = 0.008565*UA(j); %convert to kW/K
    mass_recuperator(j) = RecuperatorMass( p2,T5(j),p5,'SN',UA(j),fluid,mode,m_dotlast(j+1) );
end
A_panel_i = ones(1,length(mass_reactor))*A_panel;
mass_radiator = A_panel_i*6.75;
mass_comb = mass_reactor + mass_recuperator + mass_radiator;
set(0,'defaultAxesFontSize',14)
figure(1)
plot(mass_recuperator,mass_reactor,'k')
xlabel('Recuperator Mass [kg]','fontsize',18)
ylabel('Reactor Mass [kg]','fontsize',18)
grid on
figure(2)
plot(UA/1000,q_reactor/1000,'k')
xlabel('Recuperator Conductance [kW/K]','fontsize',18)
ylabel('Reactor Heat Input [kW]','fontsize',18)
grid on
xlim([2.5 15.5])
figure(3)
plot(UA(2:end)/1000,mass_comb,'k')
hold on
[~,I] = min(mass_comb);
scatter(UA(I)/1000,mass_comb(I),'k','filled');
text(UA(I)/1000 + 0.15,mass_comb(I) - 2.5,'A','fontsize',14)
xlabel('Recuperator Conductance [kW/K]','fontsize',18)
ylabel('Combined Mass [kg]','fontsize',18)
grid on
xlim([2.5 15.5])

figure(4)
plot(q_reactor(2:end)/1000,mass_reactor,'k')
ylabel('Reactor Mass [kg]','fontsize',18)
xlabel('Thermal Power [kW]','fontsize',18)
grid on
ylim([0 200])
xlim([125 163])

figure(5)
plot(UA(1:end-1)/1000,mass_reactor,'k')
hold on 
plot(UA(1:end-1)/1000,mass_recuperator,'--k')
plot(UA(1:end-1)/1000,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Recuperator Conductance [kW/K]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','east')
grid on
ylim([0 1500])
xlim([2 15])



% % when looking at reactor thermal power output for Alex's method vs El
% % Wakil text method
% for j=1:(length(UA)-1)
%     [ Q_original(j),Q_withGen(j) ] = ReactorMass(q_reactor(j+1),m_dotlast(j+1),p3,p4,T3(j+1),T4out(j+1),fluid,NucFuel);
% end
% 
% figure(6)
% plot(q_reactor(2:end)/1000,Q_original/1000,'k')
% hold on 
% plot(q_reactor(2:end)/1000,Q_withGen/1000,'--k')
% ylabel('Thermal Power [kW]','fontsize',18)
% xlabel('Thermal Power [kW]','fontsize',18)
% legend({'Original','New'},'fontsize',11,'location','northwest')
% grid on


% 
% % run with SS
% A_panel = [78:1:100, 105:5:185];
% for i = 1:length(A_panel)
% [minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,9000,900,2,200,'CO2',2,2,1,'UO2','SS' );
% end
% % A_panel = 70;
% % parfor i = 1:length(A_panel)
% % [minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,25000,1100,2,200,'WATER',3,2,1,'UO2','IN' );
% % end
% set(0,'defaultAxesFontSize',14)
% figure(4)
% plot(A_panel,minMass,'k')
% xlabel('Radiator panel area [m^2]','fontsize',18)
% ylabel('Optimum cycle mass [kg]','fontsize',18)
% grid on
% box on
% hold on
% [~,I] = min(minMass);
% scatter(A_panel(I),minMass(I),'k','filled')
% scatter(A_panel(38),minMass(38),'k','filled')
% text(A_panel(I)+0.7,minMass(I)-30,'B','fontsize',14)
% text(A_panel(38)+0.8,minMass(38)-20,'A','fontsize',14)
% xlim([78 185])
% ylim([750 1450])