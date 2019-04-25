% plots recuperator mass vs UA for near term stainless steel - restricted
% tube sizes to 20 mm diameter, far term stainless steel - not restricting
% tube sizes, and Inconel

% set(0,'defaultAxesFontSize',14)
% 
% 
% % Near Term Stainless Steel
% UA = [4,15];
% UA_vec = linspace(0,20);
% 
% %%%%%%%%% original values %%%%%%%%%
% % mass_550C = [42.9, 96];
% % mass_550Cline = 4.827272727*UA_vec+23.59090909;
% % mass_650C = [49.5, 129.1];
% % mass_650Cline = 7.236363636*UA_vec+20.55454545;
% 
% % updated values 4/7/2019
% mass_550C = [24.99, 48.23];
% mass_550Cline = 2.11272727272727*UA_vec+16.53909091;
% 
% 
% figure(1)
% plot(UA,mass_550C,'-ok')
% hold on
% % plot(UA,mass_650C,'-.*k')
% plot(UA_vec,mass_550Cline,'-k')
% % mass_650Cline1 = mass_650Cline(UA_vec<4);
% % UA_vec1 = UA_vec(UA_vec<4);
% % mass_650Cline2 = mass_650Cline(UA_vec>15);
% % UA_vec2 = UA_vec(UA_vec>15);
% % plot(UA_vec1,mass_650Cline1,'-.k',UA_vec2,mass_650Cline2,'-.k')
% 
% xlim([0 20])
% ylim([0 80])
% 
% % legend('550 C','650 C','location','northwest')
% legend('550 C','location','northwest')
% xlabel('UA [kW/K]','fontsize',18)
% ylabel('Recuperator Mass [kg]','fontsize',18)
% grid on
% 
% 
% 
% 
% 
% 
% 
% % Far Term Stainless Steel
% UA = [4,15];
% UA_vec = linspace(0,20);
% 
% mass_550C = [5.81, 15.8];
% mass_550Cline = 0.908182*UA_vec+2.177272727;
% 
% 
% figure(2)
% plot(UA,mass_550C,'-ok')
% hold on
% plot(UA_vec,mass_550Cline,'-k')
% 
% xlim([0 20])
% ylim([0 80])
% 
% legend('550 C','location','northwest')
% xlabel('UA [kW/K]','fontsize',18)
% ylabel('Recuperator Mass [kg]','fontsize',18)
% grid on
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % Inconel
% UA = [4,15];
% UA_vec = linspace(0,20);
% %%%%%%%%% original values %%%%%%%%%
% % mass_550C = [16.62, 39];
% % mass_550Cline = 2.034545455*UA_vec+8.481818182;
% % 
% % mass_650C = [24.7, 56.5];
% % mass_650Cline = 2.890909091*UA_vec+13.13636364;
% % 
% % mass_750C = [55.1, 118.6];
% % mass_750Cline = 5.772727273*UA_vec+32.00909091;
% % updated values 4/7/2019
% mass_550C = [2.02, 4.99];
% mass_550Cline = 0.27*UA_vec+0.94;
% 
% mass_650C = [3.61, 7.39];
% mass_650Cline = 0.343636*UA_vec+2.235454545;
% 
% mass_750C = [5.78, 18.75];
% mass_750Cline = 1.179091*UA_vec+1.063636364;
% 
% figure(3)
% plot(UA,mass_550C,'-ok')
% hold on
% plot(UA,mass_650C,'-.*k')
% plot(UA,mass_750C,'--sk')
% 
% plot(UA_vec,mass_550Cline,'-k')
% 
% mass_650Cline1 = mass_650Cline(UA_vec<4);
% UA_vec1 = UA_vec(UA_vec<4);
% mass_650Cline2 = mass_650Cline(UA_vec>15);
% UA_vec2 = UA_vec(UA_vec>15);
% plot(UA_vec1,mass_650Cline1,'-.k',UA_vec2,mass_650Cline2,'-.k')
% 
% mass_750Cline1 = mass_750Cline(UA_vec<4);
% mass_750Cline2 = mass_750Cline(UA_vec>15);
% plot(UA_vec1,mass_750Cline1,'--k',UA_vec2,mass_750Cline2,'--k')
% 
% scatter(UA,mass_550C,'ok')
% hold on
% box on
% scatter(UA,mass_650C,'*k')
% scatter(UA,mass_750C,'sk')
% 
% xlim([0 20])
% ylim([0 30])
% 
% legend(' 550 C','650 C','750 C','location','northwest')
% xlabel('UA [kW/K]','fontsize',18)
% ylabel('Recuperator Mass [kg]','fontsize',18)
% grid on


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
%%%%%%%% combined %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





set(0,'defaultAxesFontSize',14)

%create plot for recuperator mass with respect to temperature 


% Inconel
UA = [4,15];
UA_vec = linspace(0,20);
%%% old values %%%
% mass_550C = [16.62, 39];
% mass_550Cline = 2.034545455*UA_vec+8.481818182;
% 
% mass_650C = [24.7, 56.5];
% mass_650Cline = 2.890909091*UA_vec+13.13636364;
% 
% mass_750C = [55.1, 118.6];
% mass_750Cline = 5.772727273*UA_vec+32.00909091;


% updated values 4/7/2019
mass_550C = [2.02, 4.99];
mass_550Cline = 0.27*UA_vec+0.94;

mass_650C = [3.61, 7.39];
mass_650Cline = 0.343636*UA_vec+2.235454545;

mass_750C = [5.78, 18.75];
mass_750Cline = 1.179091*UA_vec+1.063636364;

figure(2)
l1 = plot(UA,mass_550C,'-ok','MarkerSize',10);
hold on
% l2 = plot(UA,mass_650C,'-*k','MarkerSize',10);
% l3 = plot(UA,mass_750C,'-sk','MarkerSize',15);

plot(UA_vec,mass_550Cline,'-k')

% mass_650Cline1 = mass_650Cline(UA_vec<4);
% UA_vec1 = UA_vec(UA_vec<4);
% mass_650Cline2 = mass_650Cline(UA_vec>15);
% UA_vec2 = UA_vec(UA_vec>15);
% plot(UA_vec1,mass_650Cline1,'-k',UA_vec2,mass_650Cline2,'-k')
% 
% mass_750Cline1 = mass_750Cline(UA_vec<4);
% mass_750Cline2 = mass_750Cline(UA_vec>15);
% plot(UA_vec1,mass_750Cline1,'-k',UA_vec2,mass_750Cline2,'-k')

% scatter(UA,mass_550C,'ok')
hold on
box on
% scatter(UA,mass_650C,'*k')
% scatter(UA,mass_750C,'sk')



% near term stainless
UA = [4,15];
UA_vec = linspace(0,20);

%%% old values %%%
% mass_550C = [42.9, 96];
% mass_550Cline = 4.827272727*UA_vec+23.59090909;

% updated values 4/7/2019
mass_550C = [24.99, 48.23];
mass_550Cline = 2.11272727272727*UA_vec+16.53909091;

l2 = plot(UA,mass_550C,'-*k','MarkerFaceColor','k','MarkerSize',10);

mass_550Cline1 = mass_550Cline(UA_vec<4);
mass_550Cline2 = mass_550Cline(UA_vec>15);
plot(UA_vec1,mass_550Cline1,'-k',UA_vec2,mass_550Cline2,'-k')




% far term stainless
mass_550C = [5.81, 15.8];
mass_550Cline = 0.908182*UA_vec+2.177272727;
l3 = plot(UA,mass_550C,'-sk','MarkerSize',10);

mass_550Cline1 = mass_550Cline(UA_vec<4);
mass_550Cline2 = mass_550Cline(UA_vec>15);
plot(UA_vec1,mass_550Cline1,'-k',UA_vec2,mass_550Cline2,'-k')


xlim([0 20])
ylim([0 60])


legend([l2,l3,l1],'Near Term Stainless','Far Term Stainless','Inconel','location','northwest')
xlabel('UA [kW/K]','fontsize',18)
ylabel('Recuperator Mass [kg]','fontsize',18)
grid on