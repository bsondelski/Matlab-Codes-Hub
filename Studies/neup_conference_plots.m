% set g as array of values from results in excel


scatter(g(:,1),g(:,5),'k');
hold on
scatter(h(:,1),h(:,5),'k*');
scatter(i(:,1),i(:,5),'ks');
scatter(j(:,1),j(:,5),'k.');
ylabel('Mass of optimized cycle [kg]')
xlabel('Percent of water in mixture')
legend('p_1 = 9 MPa', 'p_1 = 13.5 MPa','p_1 = 18 MPa', 'p_1 = 25 MPa')
box on

figure

scatter(j(:,1),j(:,12),'k');
hold on
scatter(j(:,1),j(:,7),'*','k');
legend('T_c_r_i_t_i_c_a_l','T_1','location','southeast')
box on
xlabel('Percent of water in mixture')
ylabel('Temperature [K]')

figure

plot(j(:,1),j(:,10),'-.k')
hold on
plot(j(:,1),j(:,8),'--k')
plot(j(:,1),j(:,9),'-k')

legend('m_r_a_d_i_a_t_o_r','m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','location','east')
xlabel('Percent of water in mixture')
ylabel('Mass [kg]')

figure
scatter(j(:,1),j(:,6),'k')
xlabel('Percent of water in mixture')
ylabel('Efficiency of optimized cycle')
box on


figure

scatter(j(:,1),j(:,13)/1000,'k');
hold on
scatter(j(:,1),j(:,14)/1000,'*','k');
legend('p_c_r_i_t_i_c_a_l','p_1','location','northwest')
box on
xlabel('Percent of water in mixture')
ylabel('pressure [MPa]')
% 
% figure
% plot(j(:,12),j(:,13)/1000,'k')
% xlabel('T_c_r_i_t_i_c_a_l [K]')
% ylabel('p_c_r_i_t_i_c_a_l [MPa]')
% hold on
% scatter(470,9,'filled','k')
% scatter(g(1,12),g(1,13)/1000,'k')
% scatter(g(end,12),g(end,13)/1000,'k')
% text(g(1,12),g(1,13)/1000+10,{'100% CO_2', '0% water'})
% text(g(end,12),g(end,13)/1000-10,{'81% CO_2','19% water'})
% text(470,9-3,'state 1')
% xlim([295,490])
















