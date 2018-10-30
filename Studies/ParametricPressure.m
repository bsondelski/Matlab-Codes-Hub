
p1 = [8500:1000:25000];
for i = 1:length(p1)
    try
        p1(i)
        [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),1070,2,200,'CO2',2 );
    catch
        break
    end
end

figure(1)
scatter(p1,TotalMinMass,'filled','k')
ylabel('Mass of optimized cycle [kg]')
xlabel('Turbine inlet temperature [K]')
box on

figure(2)
plot(p1,mass_reactor,'k')
hold on 
plot(p1,mass_recuperator,'--k')
plot(p1,mass_radiator,'-.k')
ylabel('Mass [kg]')
xlabel('Turbine inlet temperature [K]')
legend('m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r')