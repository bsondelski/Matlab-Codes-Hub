% change deltaTPP in Radiator for each iteration and manipulate i as
% necessary

i = 9
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,900,2,200,'CO2',2,'UO2','SS')

eps = 0.8:0.025:1;

set(0,'defaultAxesFontSize',12)
figure(1)
plot(eps,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Radiator Panel Emissivity','fontsize',18)
grid on 


figure(2)
plot(eps,mass_reactor,'k')
grid on
hold on 
plot(eps,mass_recuperator,'--k')
plot(eps,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Radiator Panel Emissivity','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','west')