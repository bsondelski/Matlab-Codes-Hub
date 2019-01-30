%Apanel H2O

A_panel = linspace(20,50,8);
parfor i = 1:length(A_panel)
[minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,25000,1100,2,200,'WATER',3,2,1,'UO2','IN' );
end
% A_panel = 70;
% parfor i = 1:length(A_panel)
% [minMass(i),UA(i),UA_min,mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i)] = minRadRecMass( A_panel(i),40000,25000,1100,2,200,'WATER',3,2,1,'UO2','IN' );
% end
set(0,'defaultAxesFontSize',14)
figure(1)
scatter(A_panel,minMass,'k')
xlabel('Radiator panel area [m^2]','fontsize',18)
ylabel('Optimum cycle mass [kg]','fontsize',18)
grid on
box on
hold on


figure(2)
plot(A_panel,mass_reactor,'k')
hold on 
plot(A_panel,mass_recuperator,'--k')
plot(A_panel,mass_radiator,'-.k')
grid on
ylabel('Mass [kg]','fontsize',18)
xlabel('Radiator panel area [m^2]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)