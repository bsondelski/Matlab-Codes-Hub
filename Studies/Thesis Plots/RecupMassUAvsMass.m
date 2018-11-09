%create plot for recuperator mass with respect to temperature for SS

set(0,'defaultAxesFontSize',12)

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
xlabel('UA [kW/K]')
ylabel('Recuperator Mass [kg]')

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

xlim([0 20])
ylim([0 170])

legend('550 C','650 C','750 C','location','northwest')
xlabel('UA [kW/K]')
ylabel('Recuperator Mass [kg]')