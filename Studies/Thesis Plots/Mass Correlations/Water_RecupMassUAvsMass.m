%create plot for recuperator mass with respect to temperature for SS

set(0,'defaultAxesFontSize',12)

UA = [4,15];
UA_vec = linspace(0,20);
mass_550C = [3.26, 7.81];
p_550C = polyfit(UA,mass_550C,1);
mass_550Cline = p_550C(1)*UA_vec+p_550C(2);

UA_650C = 15;
mass_650C = 81.7;

figure(1)
plot(UA,mass_550C,'-ok')
hold on
scatter(UA_650C,mass_650C,'*k')

plot(UA_vec,mass_550Cline,'-k')

xlim([0 20])
ylim([0 100])

legend('550 C','650 C','location','northwest')
xlabel('UA [kW/K]')
ylabel('Recuperator Mass [kg]')
grid on

%create plot for recuperator mass with respect to temperature for Inconel

UA = [4,15];
UA_vec = linspace(0,20);
mass_550C = [3.15, 4.77];
p_550C = polyfit(UA,mass_550C,1);
mass_550Cline = p_550C(1)*UA_vec+p_550C(2);

mass_650C = [5.67, 8.58];
p_650C = polyfit(UA,mass_650C,1);
mass_650Cline = p_650C(1)*UA_vec+p_650C(2);

mass_750C = [6.78, 10.17];
p_750C = polyfit(UA,mass_750C,1);
mass_750Cline = p_750C(1)*UA_vec+p_750C(2);

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
ylim([0 15])

legend('550 C','650 C','750 C','location','northwest')
xlabel('UA [kW/K]')
ylabel('Recuperator Mass [kg]')
grid on


