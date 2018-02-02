
p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=100;
T_amb=100;
fluid='CO2';
mode=2;
UA=[1000, 1921.6, 3000:1000:10000]; % was 2022.3
m_dot=0.25:0.05:3.8;

figure

for j=1:length(UA)
    UA(j)
    parfor i=1:length(m_dot)
        m_dot(i)
        [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
%         [net_power(i),~,~,~,~,~,~,~,~,~,power_T(i),power_C(i),~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
    end
    [max_power(j),m_dotmax(j)] = findMaxPower(p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
    plot(m_dot,net_power/1000)
%     figure
%     plot(m_dot,power_T,m_dot,power_C)
    
    
    hold on
end
xlabel('Mass Flow Rate [kg/s]')
ylabel('Power Output [kW]')
grid on
plot([0,6],[40,40],'k')
scatter(m_dotmax(2),max_power(2)/1000,'filled')
scatter(m_dotmax,max_power/1000)
% legend('2.022 kW/K','5 kW/K','7 kW/K','9 kW/K','11 kW/K','13 kW/K','15 kW/K','17 kW/K','19 kW/K','40 kW','Peak Power','location','northeast')
% legend('1 kW/K Conductance','2.022 kW/K Conductance','3 kW/K Conductance','5 kW/K Conductance','5 kW/K Conductance','6 kW/K Conductance',...
%     '7 kW Conductance','8 kW/K Conductance','9 kW/K Conductance','10 kW/K Conductance','40 kW Power Output','Peak Power','location','northeast')
legend('1 kW/K','2.022 kW/K','3 kW/K','5 kW/K','5 kW/K','6 kW/K',...
    '7 kW','8 kW/K','9 kW/K','10 kW/K','40 kW Power Output','40 kW Power Output','Peak Power','location','northeast')
ylim([15 70])
xlim([0 6])