%create plot for recuperator mass with respect to temperature for SS

set(0,'defaultAxesFontSize',13)

UA = [4,15];
UA_vec = linspace(0,20);
mass_550C = [42.9, 96];
mass_550Cline = 4.827272727*UA_vec+23.59090909;

mass_650C = [49.5, 129.1];
mass_650Cline = 7.236363636*UA_vec+20.55454545;

figure(1)
plot(UA,mass_550C,'-ok')
hold on
plot(UA,mass_650C,'-.*k')

plot(UA_vec,mass_550Cline,'-k')

mass_650Cline1 = mass_650Cline(UA_vec<4);
UA_vec1 = UA_vec(UA_vec<4);
mass_650Cline2 = mass_650Cline(UA_vec>15);
UA_vec2 = UA_vec(UA_vec>15);
plot(UA_vec1,mass_650Cline1,'-.k',UA_vec2,mass_650Cline2,'-.k')

xlim([0 20])
ylim([0 170])

legend('550 C','650 C','location','northwest')
xlabel('UA [kW/K]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
grid on


%create plot for recuperator mass with respect to temperature for SS

UA = [4,15];
UA_vec = linspace(0,20);
mass_550C = [16.62, 39];
mass_550Cline = 2.034545455*UA_vec+8.481818182;

mass_650C = [24.7, 56.5];
mass_650Cline = 2.890909091*UA_vec+13.13636364;

mass_750C = [55.1, 118.6];
mass_750Cline = 5.772727273*UA_vec+32.00909091;

figure(2)
plot(UA,mass_550C,'-ok')
hold on
plot(UA,mass_650C,'-.*k')
plot(UA,mass_750C,'--sk')

plot(UA_vec,mass_550Cline,'-k')

mass_650Cline1 = mass_650Cline(UA_vec<4);
UA_vec1 = UA_vec(UA_vec<4);
mass_650Cline2 = mass_650Cline(UA_vec>15);
UA_vec2 = UA_vec(UA_vec>15);
plot(UA_vec1,mass_650Cline1,'-.k',UA_vec2,mass_650Cline2,'-.k')

mass_750Cline1 = mass_750Cline(UA_vec<4);
mass_750Cline2 = mass_750Cline(UA_vec>15);
plot(UA_vec1,mass_750Cline1,'--k',UA_vec2,mass_750Cline2,'--k')

scatter(UA,mass_550C,'ok')
hold on
box on
scatter(UA,mass_650C,'*k')
scatter(UA,mass_750C,'sk')

xlim([0 20])
ylim([0 170])

legend(' 550 C','650 C','750 C','location','northwest')
xlabel('UA [kW/K]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
grid on


% 
% 
% 
% % create plot for 2 units and insulated core
% 
% UA = [4,15];
% UA_vec = linspace(0,20);
% mass_2unIns = [19.46, 47.2];
% mass_2unInsline = 2.52181818*UA_vec+9.3727272727;
% 
% figure(3)
% plot(UA_vec,mass_2unInsline,'k')
% hold on
% scatter(UA,mass_2unIns,'k','filled')
% xlabel('UA [kW/K]','fontsize',18)
% ylabel('Recuperator Mass [kg]','fontsize',18)
% grid on
% 
% 
% 
% 
% 
% 
% %%%%%%%% combined %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% 
% 
% set(0,'defaultAxesFontSize',14)
% 
% %create plot for recuperator mass with respect to temperature for SS
% 
% UA = [4,15];
% UA_vec = linspace(0,20);
% mass_550C = [16.62, 39];
% mass_550Cline = 2.034545455*UA_vec+8.481818182;
% 
% mass_650C = [24.7, 56.5];
% mass_650Cline = 2.890909091*UA_vec+13.13636364;
% 
% mass_750C = [55.1, 118.6];
% mass_750Cline = 5.772727273*UA_vec+32.00909091;
% 
% figure(2)
% l1 = plot(UA,mass_550C,'-ok','MarkerSize',10);
% hold on
% l2 = plot(UA,mass_650C,'-*k','MarkerSize',10);
% l3 = plot(UA,mass_750C,'-sk','MarkerSize',10);
% 
% plot(UA_vec,mass_550Cline,'-k')
% 
% mass_650Cline1 = mass_650Cline(UA_vec<4);
% UA_vec1 = UA_vec(UA_vec<4);
% mass_650Cline2 = mass_650Cline(UA_vec>15);
% UA_vec2 = UA_vec(UA_vec>15);
% plot(UA_vec1,mass_650Cline1,'-k',UA_vec2,mass_650Cline2,'-k')
% 
% mass_750Cline1 = mass_750Cline(UA_vec<4);
% mass_750Cline2 = mass_750Cline(UA_vec>15);
% plot(UA_vec1,mass_750Cline1,'-k',UA_vec2,mass_750Cline2,'-k')
% 
% % scatter(UA,mass_550C,'ok')
% hold on
% box on
% % scatter(UA,mass_650C,'*k')
% % scatter(UA,mass_750C,'sk')
% 
% 
% 
% 
% UA = [4,15];
% UA_vec = linspace(0,20);
% mass_550C = [42.9, 96];
% mass_550Cline = 4.827272727*UA_vec+23.59090909;
% 
% l4 = plot(UA,mass_550C,'--ok','MarkerFaceColor','k','MarkerSize',10);
% 
% mass_550Cline1 = mass_550Cline(UA_vec<4);
% mass_550Cline2 = mass_550Cline(UA_vec>15);
% plot(UA_vec1,mass_550Cline1,'--k',UA_vec2,mass_550Cline2,'--k')
% 
% xlim([0 20])
% ylim([0 170])
% 
% 
% legend([l1,l2,l3,l4],'550 C Inconel','650 C Inconel','750 C Inconel','550 C Stainless Steel','location','northwest')
% xlabel('UA [kW/K]','fontsize',18)
% ylabel('Recuperator Mass [kg]','fontsize',18)
% grid on