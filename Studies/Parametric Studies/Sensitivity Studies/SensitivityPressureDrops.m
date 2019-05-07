% change pressure drops for each iteration and manipulate i as
% necessary

i = 9
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i),~,~,~ ] = minimizeTotalMassMixtures( 40000,9000,900,2,200,'CO2',2,'UO2','SN')


% i = 9;
    [~,efficiency,D_T(i),D_c(i),Ma_T(i),Ma_c(i),Anozzle(i),q_reactor(i),...
    q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),energy(i),p1,T2(i),p2,T3(i),p3,~,p4,T5(i),...
    p5,T6(i),p6,~,Vratio(i)] = BraytonCycle(m_dot(i),9000,900,2,UA(i),...
    A_panel(i),200,'CO2',2,1);
cyc_efficiency(i) = efficiency(1);

pressDrop = [2.5, 5, 7.5, 8.96, 10, 12.5, 15, 17.5, 20];
figure(1)
plot(pressDrop,TotalMinMass,'k')
grid on
hold on 
scatter(pressDrop(4),TotalMinMass(4),'k')
xlabel('Percent of Working Pressure Lost','fontsize',18)
ylabel('Optimum Cycle Mass [kg]','fontsize',18)

figure(2)
plot(pressDrop,mass_reactor,'k')
grid on
hold on 
plot(pressDrop,mass_recuperator,'--k')
plot(pressDrop,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Percent of Working Pressure Lost','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','northwest')

figure(3)
plot(pressDrop,cyc_efficiency,'k')
grid on
xlabel('Percent of Working Pressure Lost','fontsize',18)
ylabel('Cycle Efficiency','fontsize',18)


figure(1)
plot(DeltaPReactor,TotalMinMass,'k')
grid on
xlabel('Pressure Drop in Reactor','fontsize',18)
ylabel('Optimum Cycle Mass [kg]','fontsize',18)

figure(2)
plot(DeltaPReactor,mass_reactor,'k')
grid on
hold on 
plot(DeltaPReactor,mass_recuperator,'--k')
plot(DeltaPReactor,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Pressure Drop in Reactor','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','east')

figure(1)
plot(DeltaPHEX,TotalMinMass,'k')
grid on
xlabel('Pressure Drop in Reactor','fontsize',18)
ylabel('Optimum Cycle Mass [kg]','fontsize',18)

figure(2)
plot(DeltaPHEX,mass_reactor,'k')
grid on
hold on 
plot(DeltaPHEX,mass_recuperator,'--k')
plot(DeltaPHEX,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Pressure Drop in Reactor','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','east')

% % 2.5% i = 1
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17973.8775;
% p4 = 17838.9675;
% p5 = 9063.9675;
% p6 = 9025.3575;
% PR_T = PR_c;

% % 5% i = 2
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17947.755;
% p4 = 17677.935;
% p5 = 9127.935;
% p6 = 9050.715;
% PR_T = PR_c;

% % 7.5% i = 3
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17921.6325;
% p4 = 17516.9025;
% p5 = 9191.9025;
% p6 = 9076.0725;
% PR_T = PR_c;

% % 8.96% i = 4
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17906.37696;
% p4 = 17422.85952;
% p5 = 9229.25952;
% p6 = 9090.88128;
% PR_T = PR_c;

% % 10% i = 5
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17895.51;
% p4 = 17355.87;
% p5 = 9255.87;
% p6 = 9101.43;
% PR_T = PR_c;

% % 12.5% i = 6
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17869.3875;
% p4 = 17194.8375;
% p5 = 9319.8375;
% p6 = 9126.7875;
% PR_T = PR_c;

% % 15% i = 7
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17843.265;
% p4 = 17033.805;
% p5 = 9383.805;
% p6 = 9152.145;
% PR_T = PR_c;

% increase radiator poind find range to 100 to 150

% % 17.5% i = 8
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17817.1425;
% p4 = 16872.7725;
% p5 = 9447.7725;
% p6 = 9177.5025;
% PR_T = PR_c;
% 
% % 20% i = 9
% p2 = PR_c*p1;             % pressure at compressor outlet
% p3 = 17791.02;
% p4 = 16711.74;
% p5 = 9511.74;
% p6 = 9202.86;
% PR_T = PR_c;
