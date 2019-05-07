
Tamb = 0:10:250;
parfor i = 1:length(Tamb)
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i),~,~,~ ] = minimizeTotalMassMixtures( 40000,9000,900,2,Tamb(i),'CO2',2,'UO2','SN')
end

set(0,'defaultAxesFontSize',12)
figure(1)
plot(Tamb,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Heat Sink Temperature [K]','fontsize',18)
grid on 


figure(2)
plot(Tamb,mass_reactor,'k')
grid on
hold on 
plot(Tamb,mass_recuperator,'--k')
plot(Tamb,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Heat Sink Temperature [K]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','west')
ylim([0 700])
