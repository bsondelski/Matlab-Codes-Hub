% run all recuperator configurations
clear
RecupMatl = {'U1','U2','U4','I1','I2','I4'};

parfor i = 1:length(RecupMatl)
   Matl = string(RecupMatl(i))
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,1100,2,200,'CO2',2,'UO2',Matl );

end
save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\RecuperatorConfig.mat'

plot([1 2 3],TotalMinMass(1:3),'-ok')
hold on
plot([1 2 3],TotalMinMass(4:6),'--*k')
grid on
xlabel('Number of Parallel Units')
ylabel('Optimum Cycle Mass [kg]')
legend('Not Insulated Core','Insulated Core')