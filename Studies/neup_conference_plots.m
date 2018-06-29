% set g as array of values from results in excel


scatter(g(:,1),g(:,5),'k');
ylabel('Mass of optimized cycle [kg]')
xlabel('Percent of water in mixture')
box on

figure

scatter(g(:,1),g(:,12),'k');
hold on
scatter(g(:,1),g(:,7),'*','k');
legend('T_c_r_i_t_i_c_a_l','T_1','location','southeast')
box on
xlabel('Percent of water in mixture')
ylabel('Temperature [K]')

figure

plot(g(:,1),g(:,10),'-.+k')
hold on
plot(g(:,1),g(:,8),'--ok')
plot(g(:,1),g(:,9),'-*k')

legend('m_r_a_d_i_a_t_o_r','m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','location','east')
xlabel('Percent of water in mixture')
ylabel('Mass [kg]')

figure
scatter(g(:,1),g(:,6),'k')
xlabel('Percent of water in mixture')
ylabel('Efficiency of optimized cycle')
box on


figure

scatter(g(:,1),g(:,13)/1000,'k');
hold on
scatter(g(:,1),g(:,14)/1000,'*','k');
legend('p_c_r_i_t_i_c_a_l','p_1','location','northwest')
box on
xlabel('Percent of water in mixture')
ylabel('pressure [MPa]')

figure
plot(g(:,12),g(:,13)/1000,'k')
xlabel('T_c_r_i_t_i_c_a_l [K]')
ylabel('p_c_r_i_t_i_c_a_l [MPa]')
hold on
scatter(470,9,'filled','k')
scatter(g(1,12),g(1,13)/1000,'k')
scatter(g(end,12),g(end,13)/1000,'k')
text(g(1,12),g(1,13)/1000+10,{'100% CO_2', '0% water'})
text(g(end,12),g(end,13)/1000-10,{'81% CO_2','19% water'})
text(470,9-3,'state 1')
xlim([295,490])
















