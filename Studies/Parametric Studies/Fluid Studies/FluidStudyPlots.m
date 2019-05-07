
% TotalMinMass = TotalMinMass(1:2:11);
% TotalMinMass(5) = [];
% H2O = H2O(1:2:11);
% H2O(5) = [];
% 
% mass_reactor = mass_reactor(1:2:11);
% mass_reactor(5) = [];
% 
% mass_recuperator = mass_recuperator(1:2:11);
% mass_recuperator(5) = [];
% 
% mass_radiator = mass_radiator(1:2:11);
% mass_radiator(5) = [];
% 
% T_DewPoint = T_DewPoint(1:2:11);
% T_DewPoint(5) = [];
% T_DewPoint = T_DewPoint';
% 
% 
% T1 = T1(1:2:11);
% T1(5) = [];
H2O(end) = 100;

figure(1)
scatter(H2O(1:16)./100,TotalMinMass(1:16),'filled','k')
hold on 
scatter(H2O(20:21)./100,TotalMinMass(20:21),'filled','k')
xlim([0 1])
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
ylabel('Minimum Cycle Mass [kg]','fontsize',18)
grid on
box on

figure(3)
plot(H2O(1:16)./100,mass_reactor(1:16),'k')
hold on 
plot(H2O(20:21)./100,mass_reactor(20:21),'k')
plot(H2O(1:16)./100,mass_recuperator(1:16),'--k')
plot(H2O(20:21)./100,mass_recuperator(20:21),'--k')
plot(H2O(1:16)./100,mass_radiator(1:16),'-.k')
plot(H2O(20:21)./100,mass_radiator(20:21),'-.k')
xlim([0 1])
ylabel('Mass [kg]','fontsize',18)
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'location','northwest')
grid on

figure(2)
leg1 = scatter(H2O(1:16)./100,T1(1:16),'filled','k');
hold on 
box on
scatter(H2O(20:21)./100,T1(20:21),'filled','k')
leg2 = scatter(H2O./100,T_DewPoint,'*','MarkerEdgeColor',[0 0.4470 0.7410]);
xlim([0 1])
legend([leg1, leg2], 'T_1','T Dew Point','location','southeast')
ylabel('Temperature [K]','fontsize',18)
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
grid on

figure(4)
leg1 = scatter(H2O(1:16)./100,A_panel(1:16),'filled','k');
hold on 
box on
scatter(H2O(20:21)./100,A_panel(20:21),'filled','k')
leg2 = scatter(H2O(1:16)./100,ApanelMin(1:16),'*','MarkerEdgeColor',[0 0.4470 0.7410]);
scatter(H2O(20:21)./100,ApanelMin(20:21),'*','MarkerEdgeColor',[0 0.4470 0.7410])
xlim([0 1])
legend([leg1, leg2],'A_p_a_n_e_l','A_p_a_n_e_l_,_m_i_n','location','northeast')
ylabel('Area [m^2]','fontsize',18)
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
grid on


figure(5)
scatter(H2O(1:16)./100,efficiency_cycle(1:16),'filled','k')
xlim([0 1])
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
ylabel('Cycle Efficiency','fontsize',18)
grid on
box on



figure(6)
scatter(H2O(1:16)./100,q_reactor(1:16)/1000,'filled','k')
xlim([0 1])
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
ylabel('Reactor Heat Input [kW]','fontsize',18)
grid on
box on

figure(7)
scatter(H2O(1:16)./100,UA(1:16)/1000,'filled','k')
hold on
scatter(H2O(20:21)./100,UA(20:21)/1000,'filled','k')
xlim([0 1])
xlabel('Mole Fraction H_2O','fontsize',18)
ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.14*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
ylabel('Recuperator Conductance [kW/K]','fontsize',18)
grid on
box on