
%obtain min mass for various pressures - saved results are run at:
% 1050K for inconel -> p1 = [2000:500:9000];
% 980K for SS -> p1 = [6000:500:10000];
p1 = [2000:500:10000];
parfor i = 1:length(p1)
    
    p1(i)
    [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),900,2,200,'CO2',2 );
end
set(0,'defaultAxesFontSize',12)
figure(1)
plot(p1./1000,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
box on
grid on

figure(2)
plot(p1./1000,mass_reactor,'k')
hold on 
plot(p1./1000,mass_recuperator,'--k')
plot(p1./1000,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','west')
grid on


