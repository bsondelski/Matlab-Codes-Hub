% add RadDens to end of inputs for MinimizeTotalMass, PanelBoundFind,
% MinRadRedMass, totalMass

RadDens = 3:0.25:7.5;
parfor i = 1:length(RadDens)
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,900,2,200,'CO2',2,'UO2','SS',RadDens(i))
end

% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Sensitivity Results\RadDens.mat'

set(0,'defaultAxesFontSize',12)
figure(2)
% hold on
plot(RadDens,TotalMinMass,'k')
% hold on
% scatter(Trej(21),TotalMinMass(21),'filled','k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Radiator Mass Density [kg/m^2]','fontsize',18)
box on
% legend('Inconel','Stainless Steel','location','northwest')
grid on

figure(3)
plot(RadDens,mass_reactor,'k')
hold on 
plot(RadDens,mass_recuperator,'--k')

plot(RadDens,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Radiator Mass Density [kg/m^2]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','east')
grid on