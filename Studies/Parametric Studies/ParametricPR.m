PR = [2:0.1:3];
% p1 = 18000/PR
for i = 1:length(PR)
    p1(i) = 18000/PR(i);
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),980,PR(i),200,'CO2',2 );

end

figure(1)
% hold on
scatter(PR,TotalMinMass,'filled','k')
ylabel('Mass of optimized cycle [kg]','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
box on
grid on


figure(2)
plot(PR,mass_reactor,'k')
hold on 
plot(PR,mass_recuperator,'--k')
plot(PR,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11,'location','west')
grid on

%%%% for temperatures
for i=1:length(TotalMinMass)
    [net_power(i),efficiency,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor(i),...
    q_rad(i),T1(i),Power_T,Power_c,HEXeffect(i),energy,~,T2(i),p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6(i),p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),900,PR(i),UA(i),...
    A_panel(i),200,'CO2',2,0);
cyc_eff(i) = efficiency(1);
end

figure(1)
plot(PR,T1,'-*')
hold on
plot(PR,T2,'-x')
plot(PR,T3,'-o')
plot(PR,T5,'-s')
plot(PR,T6,'-+')
delta = 0.02;
text(PR(end)+delta,T1(end),'T_1','fontsize',12)
text(PR(end)+delta,T2(end)-10,'T_2','fontsize',12)
text(PR(end)+delta,T3(end)-5,'T_3','fontsize',12)
text(PR(end)+delta,T5(end)+5,'T_5','fontsize',12)
text(PR(end)+delta,T6(end)+10,'T_6','fontsize',12)
grid on
xlabel('Pressure Ratio','fontsize',18)
ylabel('Cycle Temperatures [K]','fontsize',18)
xlim([2 3.1])

figure(2)
plot(PR,HEXeffect,'k')
grid on
xlabel('Pressure Ratio','fontsize',18)
ylabel('Recuperator Effectiveness','fontsize',18)

figure(3)
plot(PR,cyc_eff,'k')
grid on
xlabel('Pressure Ratio','fontsize',18)
ylabel('Efficiency of Optimum Mass','fontsize',18)



%%%%%%%%%%%%%%%% for Mach numbers %%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),980,PR(i),UA(i),...
    A_panel(i),200,'CO2',2,0);
end

figure(3)
plot(PR,Ma_T)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(4)
plot(PR,Ma_c)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on


% use all results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(PR,TotalMinMass,'k')
hold on
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
box on
grid on

[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 1050 K'])
xlim([2 3.3])












