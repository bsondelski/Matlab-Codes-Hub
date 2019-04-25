
% TotalMinMass = TotalMinMass(1:2:11);
% TotalMinMass(5) = [];
% H2O = H2O(1:2:11);
% H2O(5) = [];
% 
% mass_reactor = mass_reactor(1:2:11);
% mass_reactor(5) = [];
% 
% mass_recuperator = mass_recuperator(1:2:11);
% mass_recuperator(5) = [];
% 
% mass_radiator = mass_radiator(1:2:11);
% mass_radiator(5) = [];
% 
% T_DewPoint = T_DewPoint(1:2:11);
% T_DewPoint(5) = [];
% T_DewPoint = T_DewPoint';
% 
% 
% T1 = T1(1:2:11);
% T1(5) = [];
H2O(end) = 100;

figure(1)
scatter(H2O(1:16),TotalMinMass(1:16),'filled','k')
hold on 
scatter(H2O(20),TotalMinMass(20),'filled','k')
xlim([0 100])
xlabel('percent H2O')
ylabel('Minimum Cycle Mass [kg]')
grid on
box on

figure(3)
plot(H2O(1:16),mass_reactor(1:16),'k')
hold on 
plot(H2O(1:16),mass_recuperator(1:16),'--k')
plot(H2O(1:16),mass_radiator(1:16),'-.k')
xlim([0 100])
ylabel('Mass [kg]','fontsize',18)
xlabel('percent H2O','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','northwest')
grid on

figure(2)
scatter(H2O(1:16),T1(1:16),'filled')
hold on 
box on
scatter(H2O(1:16),T_DewPoint(1:16),'*')
xlim([0 100])
legend('T_1','T Dew Point','location','southeast')
ylabel('Temperature [K]','fontsize',18)
xlabel('percent H2O','fontsize',18)
grid on

figure(4)
scatter(H2O(1:16),A_panel(1:16),'filled')
hold on 
box on
scatter(H2O(1:16),ApanelMin(1:16),'*')
xlim([0 100])
legend('A_p_a_n_e_l','A_p_a_n_e_l_,_m_i_n','location','southeast')
ylabel('Area [m^2]','fontsize',18)
xlabel('percent H2O','fontsize',18)
grid on


figure(5)
scatter(H2O(1:16),efficiency_cycle(1:16),'filled')
xlim([0 100])
xlabel('percent H2O')
ylabel('Cycle Efficiency')
grid on
box on



figure(6)
scatter(H2O(1:16),q_reactor(1:16)/1000,'filled')
xlim([0 100])
xlabel('percent H2O')
ylabel('Reactor Heat Input [kW]')
grid on
box on

figure(7)
scatter(H2O(1:16),UA(1:16)/1000,'filled')
xlim([0 100])
xlabel('percent H2O')
ylabel('Recuperator Conductance [kW/K]')
grid on
box on