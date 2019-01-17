Trej = [0:10:300];
parfor i = 1:length(Trej)
    Trej(i)
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,900,2,Trej(i),'CO2',2 );

end

TotalMinMass(27:end) = [];
Trej(27:end) = [];
mass_radiator(27:end) = [];
mass_recuperator(27:end) = [];
mass_reactor(27:end) = [];

set(0,'defaultAxesFontSize',12)
figure(2)
% hold on
plot(Trej,TotalMinMass,'k')
% hold on
% scatter(Trej(21),TotalMinMass(21),'filled','k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Sink Temperature [K]','fontsize',18)
box on
% legend('Inconel','Stainless Steel','location','northwest')
grid on

figure(3)
plot(Trej,mass_reactor,'k')
hold on 
plot(Trej,mass_recuperator,'--k')
plot(Trej,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Sink Temperature [K]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','east')
grid on