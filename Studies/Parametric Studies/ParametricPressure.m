
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

set(0,'defaultAxesFontSize',12)
figure(3)
plot(p1./1000,UA./1000,'k')
ylabel('Recuperator Conductance [kW/K]','fontsize',18)
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
box on
grid on

% load pressure dependent data
figure(2)
plot(p1./1000,mass_recuperator,'--k')
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
hold on 
grid on

% load data without pressure dependence 
plot(p1./1000,mass_recuperator,'k')

ylabel('Recuperator Mass [kg]','fontsize',18)
legend({'Includes Pressure Dependence','No Pressure Dependence'},'fontsize',13,'location','northeast')












for i=1:length(TotalMinMass)
    i = 41
    [net_power(i),efficiency,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor(i),...
    q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),energy,~,T2(i),p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6(i),p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),900,2,UA(i),...
    A_panel(i),200,'CO2',2,0);
cyc_eff(i) = efficiency(1);
end


figure(1)
plot(p1,T1,'-*')
hold on
plot(p1,T2,'-x')
plot(p1,T3,'-o')
plot(p1,T5,'-s')
plot(p1,T6,'-+')
delta = 0.02;
text(p1(end)+delta,T1(end),'T_1','fontsize',12)
text(p1(end)+delta,T2(end)-10,'T_2','fontsize',12)
text(p1(end)+delta,T3(end)-5,'T_3','fontsize',12)
text(p1(end)+delta,T5(end)+5,'T_5','fontsize',12)
text(p1(end)+delta,T6(end)+10,'T_6','fontsize',12)
grid on
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
ylabel('Cycle Temperatures [K]','fontsize',18)
xlim([2 3.1])


figure(2)
plot(p1./1000,HEXeffect,'k')
grid on
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
ylabel('Recuperator Effectiveness','fontsize',18)

figure(3)
plot(p1./1000,cyc_eff,'k')
grid on
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
ylabel('Efficiency of Optimum Cycle','fontsize',18)