
T4 = [900:10:1100];
parfor i = 1:length(T4)
    T4(i)
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,T4(i),2,200,'CO2',2 );

end

figure(1)
% hold on
scatter(T4,TotalMinMass,'filled','k')
ylabel('Mass of optimized cycle [kg]','fontsize',18)
xlabel('Turbine inlet temperature [K]','fontsize',18)
box on
% legend('Inconel','Stainless Steel','location','northwest')
% grid on

figure(2)
plot(T4,mass_reactor,'k')
hold on 
plot(T4,mass_recuperator,'--k')
plot(T4,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Turbine inlet temperature [K]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)