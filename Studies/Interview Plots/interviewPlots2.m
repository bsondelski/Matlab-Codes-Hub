A_panel = 30:5:100;
parfor i = 1:length(A_panel)
[minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,9000,1100,2,200,'CO2',2,2,1 );
end

figure(1)
scatter(A_panel,minMass,'filled')
xlabel('Radiator panel area [m^2]','fontsize',18)
ylabel('Optimum cycle mass [kg]','fontsize',18)
grid on
box on

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
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)