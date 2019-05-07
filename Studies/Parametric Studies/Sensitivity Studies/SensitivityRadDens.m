% manipulate mass_radiator in total_mass and i - run optimizations

i = 5
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i),~,~,~ ] = minimizeTotalMassMixtures( 40000,9000,900,2,200,'CO2',2,'UO2','SN')

RadDens = [1.5,3,5,6,7.5];

set(0,'defaultAxesFontSize',12)
figure(2)
plot(RadDens,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Radiator Mass Density [kg/m^2]','fontsize',18)
xlim([1.5 7.5])
box on
grid on

figure(3)
plot(RadDens,mass_reactor,'k')
hold on 
plot(RadDens,mass_recuperator,'--k')
plot(RadDens,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Radiator Mass Density [kg/m^2]','fontsize',18)
xlim([1.5 7.5])
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','east')
grid on