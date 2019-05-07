% run with SS
% A_panel = [40:1:55, 60:5:85];
A_panelmin = 77.8001;
A_panel = [77:1:88 90:5:190];
for i = 1:length(A_panel)
[minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,9000,900,2,200,'CO2',2,2,1,'UO2','SN' );
end
% A_panel = 70;
% parfor i = 1:length(A_panel)
% [minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,25000,1100,2,200,'WATER',3,2,1,'UO2','IN' );
% end
set(0,'defaultAxesFontSize',14)
figure(1)
plot(A_panel,minMass,'k')
xlabel('Radiator panel area [m^2]','fontsize',18)
ylabel('Optimum cycle mass [kg]','fontsize',18)
grid on
box on
hold on
[~,I] = min(minMass);
scatter(A_panel(I),minMass(I),'k','filled')
scatter(A_panel(30),minMass(30),'k','filled')
text(A_panel(I)+1,minMass(I)-25,'B','fontsize',14)
text(A_panel(30)+1,minMass(30)-20,'A','fontsize',14)
xlim([77 185])
ylim([680 1380])

% plot(A_panel,mass_recuperator)
% hold on 
% plot(A_panel,mass_reactor)
% plot(A_panel,mass_radiator)
% xlabel('Radiator panel area [m^2]','fontsize',18)
% ylabel('Component masses [kg]','fontsize',18)
% grid on
% box on


figure(2)
plot(A_panel,mass_reactor,'k')
hold on 
plot(A_panel,mass_recuperator,'--k')
plot(A_panel,mass_radiator,'-.k')
grid on
ylabel('Mass [kg]','fontsize',18)
xlabel('Radiator panel area [m^2]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','east')
xlim([77 185])

% looking at why there is a minimum mass - comparing large and small
% radiator sizes
for i=3:length(A_panel)
    if i == 3 || i == length(A_panel)
        ploton = 1;
    else
        ploton = 0;
    end
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad(i),T1(i),Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,1100,2,UA(i),...
    A_panel(i),200,'CO2',2,ploton)
efficiency(i) = cyc_efficiency(1);
end

figure
plot(A_panel(3:end),efficiency(3:end))
ylabel('Cycle Efficiency','fontsize',18)
xlabel('Radiator panel area [m^2]','fontsize',18)
figure
plot(A_panel(3:end),q_rad(3:end))
ylabel('Radiated Heat','fontsize',18)
xlabel('Radiator panel area [m^2]','fontsize',18)
figure
plot(A_panel(3:end),T1(3:end))
ylabel('Compressor Inlet Temperature [K]','fontsize',18)
xlabel('Radiator panel area [m^2]','fontsize',18)