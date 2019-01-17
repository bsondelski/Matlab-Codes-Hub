clear
p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=100;
T_amb=100;
fluid='CO2';
mode=2;
desiredPower = 40000;
UA = 6000;

m_dot=0.35:0.05:3;

set(0,'defaultAxesFontSize',14)


for i=1:length(m_dot)
    m_dot(i)
    [net_power(i),cyc_eff,~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),~,~,T2(i),~,~,~,T4plot(i),~,T5(i),~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    efficiency(i) = cyc_eff(1);
end
options = [];
[max_power,m_dotmax] = findMaxPower2(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options);
[~,~,~,~,~,~,~,q_reactormax,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dotmax,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);

carnot_eff = (T4-T1)./T4;
% plot(q_reactor/1000,net_power/1000)
% hold on
% scatter(q_reactormax/1000,max_power/1000,'k')
% xlabel('Reactor Heat Output [kW]')
% ylabel('Cycle Power Output [kW]')
% ylim([0 60])
% grid on
% 
% 
% ax1 = gca;
% ax1_pos = ax1.Position;
% 
% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','bottom',...
%     'YAxisLocation','right',...
%     'Color','none');
% line(q_reactor/1000,efficiency,'Parent',ax2,'Color','k')
% line(q_reactor/1000,carnot_eff,'Parent',ax2,'Color','r')
% ylabel('Cycle Efficiency')
figure
plot(q_reactor/1000,net_power/1000)
hold on
scatter(q_reactormax/1000,max_power/1000,'k')
xlabel('Reactor Heat Output [kW]')
ylabel('Cycle Power Output [kW]')
ylim([0 60])
xlim([0 1000])
grid on

figure
plot(q_reactor/1000,efficiency,'k')
hold on
plot(q_reactor/1000,carnot_eff,'k')
text (q_reactor(1)/1000+20,carnot_eff(1),'Carnot Efficiency','FontSize',14)
text (q_reactor(1)/1000+30,efficiency(1),'Cycle Efficiency','FontSize',14)
xlabel('Reactor Heat Output [kW]')
ylabel('Efficiency')
grid on

figure
plot(q_reactor/1000,T4plot,'k',q_reactor/1000,T1,'k')
text (q_reactor(1)/1000-35,T4plot(1)-10,'T_H','FontSize',14)
text (q_reactor(1)/1000-35,T1(1)-10,'T_C','FontSize',14)
xlabel('Reactor Heat Output [kW]')
ylabel('Min/Max Cycle Temperatures [K]')
ylim([250 1200])
grid on

figure
plot(q_reactor/1000,T5,'k',q_reactor/1000,T2,'k')
text (q_reactor(1)/1000-35,T5(1)-18,'T_H_,_i_n','FontSize',14)
text (q_reactor(1)/1000-35,T2(1)-10,'T_C_,_i_n','FontSize',14)
xlabel('Reactor Heat Output [kW]')
ylabel('Recuperator Inlet Temperatures [K]')
ylim([290 1150])
grid on

figure
plot(q_reactor/1000,HEXeffect,'k')
grid on
xlabel('Reactor Heat Output [kW]')
ylabel('Heat Exchanger Effectiveness')
