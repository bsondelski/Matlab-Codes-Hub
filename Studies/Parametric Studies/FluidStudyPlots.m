
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


figure(1)
scatter(H2O,TotalMinMass,'filled')
xlim([0 100])
xlabel('percent H2O')
ylabel('Minimum Cycle Mass [kg]')
grid on
box on

figure(3)
plot(H2O,mass_reactor,'k')
hold on 
plot(H2O,mass_recuperator,'--k')
plot(H2O,mass_radiator,'-.k')
xlim([0 100])
ylabel('Mass [kg]','fontsize',18)
xlabel('percent H2O','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','east')
grid on

figure(2)
scatter(H2O,T1,'filled')
hold on 
box on
scatter(H2O,T_DewPoint,'*')
xlim([0 100])
legend('T_1','T Dew Point','location','southeast')
ylabel('Temperature [K]','fontsize',18)
xlabel('percent H2O','fontsize',18)
grid on