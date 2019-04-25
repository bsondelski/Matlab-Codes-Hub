% figure 1 - cycle power output vs Reactor heat output for one UA value (6 kW/K)
% figure 2 - carnot efficiency and cycle efficiency vs Reactor heat output
% figure 3 - minimum and maximum cycle temperatures vs Reactor heat output
% figure 4 - recuperator hot and cold inlet temperatures vs Reactor heat output
% figure 5 - recuperator effectiveness vs Reactor heat output

clear
p1=9000;
T4=900;
PR_c=2;
A_panel=175;
T_amb=200;
fluid='CO2';
mode=2;
desiredPower = 40000;
UA = 6000;

m_dot=0.4:0.05:3;

set(0,'defaultAxesFontSize',14)


for i=1:length(m_dot)
    m_dot(i)
    [net_power(i),cyc_eff,~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),~,~,T2(i),~,~,~,T4plot(i),~,T5(i),~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    efficiency(i) = cyc_eff(1);
end
options = [];
[max_power,m_dotmax] = findMaxPowerGivenUA(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options);
[~,~,~,~,~,~,~,q_reactormax,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dotmax,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);

carnot_eff = (T4-T1)./T4;

figure(1)
plot(q_reactor/1000,net_power/1000)
hold on
c = scatter(q_reactormax/1000,max_power/1000,'k');
xlabel('Reactor Heat Output [kW]')
ylabel('Cycle Power Output [kW]')
ylim([20 55])
xlim([0 800])
grid on
text(q_reactor(end)/1000+10,net_power(end)/1000,[num2str(UA/1000) ' kW/K'],'FontSize',14)
legend(c,'Peak Power')

figure(2)
plot(q_reactor/1000,efficiency,'k')
hold on
plot(q_reactor/1000,carnot_eff,'k')
text (q_reactor(1)/1000+25,carnot_eff(1),'Carnot Efficiency','FontSize',14)
text (q_reactor(1)/1000+30,efficiency(1),'Cycle Efficiency','FontSize',14)
xlabel('Reactor Heat Output [kW]')
ylabel('Efficiency')
xlim([0 650])
grid on

figure(3)
plot(q_reactor/1000,T4plot,'k',q_reactor/1000,T1,'k')
text (q_reactor(1)/1000-35,T4plot(1)-10,'T_H','FontSize',14)
text (q_reactor(1)/1000-35,T1(1)-10,'T_C','FontSize',14)
xlabel('Reactor Heat Output [kW]')
ylabel('Min/Max Cycle Temperatures [K]')
ylim([250 1000])
xlim([0 650])
grid on

figure(4)
plot(q_reactor/1000,T5,'k',q_reactor/1000,T2,'k')
text (q_reactor(1)/1000-35,T5(1)-18,'T_H_,_i_n','FontSize',14)
text (q_reactor(1)/1000-35,T2(1)-10,'T_C_,_i_n','FontSize',14)
xlabel('Reactor Heat Output [kW]')
ylabel('Recuperator Inlet Temperatures [K]')
ylim([290 1150])
grid on

figure(5)
plot(q_reactor/1000,HEXeffect,'k')
grid on
xlabel('Reactor Heat Output [kW]')
ylabel('Heat Exchanger Effectiveness')
xlim([0 650])
