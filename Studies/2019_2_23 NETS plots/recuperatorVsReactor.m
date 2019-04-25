% plot recuperator conductance vs reactor heat input
clear

set(0,'defaultAxesFontSize',14)

p1=9000;
T4=900;
PR_c=2;
A_panel=175;
T_amb=200;
fluid='CO2';
mode=2;
desiredPower = 40000;

[ UA_min,m_dotcycle_max ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);
UA_min = UA_min;
UA=UA_min:100:20000;
m_dotlast(1) = m_dotcycle_max;

[net_power,~,~,~,~,~,~,q_reactor(1),...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotcycle_max,p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0);


options = [];
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor(j+1),...
    ~,~,m_dotlast(j+1),~,~,~,~] =...
    SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast(j),options);
end


% find qreactor for dotted portion of the line
m_dotlast2(1) = m_dotcycle_max;
q_reactor2(1) = q_reactor(1);
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor2(j+1),...
    ~,~,m_dotlast2(j+1),~,~,~,~] =...
    SpecifiedPower3(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast2(j),options);
end

 for j=1:length(UA)
[net_power_j(j),~,~,~,~,~,~,q_reactor_j(j),...
    ~,~,~,~,~,~,~,~,~,T3(j),p3(j),T4out(j),p4(j),T5(j),...
    ~,~,~,~,~] = BraytonCycle(m_dotlast(j),p1,T4,PR_c,UA(j),...
    A_panel,T_amb,fluid,mode,0);
end

% plot for UA vs Q_dot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(q_reactor/1000,UA/1000,'k')
hold on
plot(q_reactor2/1000,UA/1000,'--k','linewidth',1.1)
scatter(q_reactor2(1)/1000,UA_min/1000,'k','filled')
xlabel('Reactor Heat Output [kW]','fontsize',19)
ylabel('Recuperator Conductance [kW/K]','fontsize',19)
grid on
ylim([0 21])
xlim([0 800])