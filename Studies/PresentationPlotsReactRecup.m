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

[ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);
% UA_min = UA_min + 400;
UA_min = UA_min;
UA=UA_min:100:20000; % was 2022.3
m_dotlast(1) = m_dotcycle_max;

[net_power,~,~,~,~,~,~,q_reactor(1),...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotcycle_max,p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0)


options = [];
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor(j+1),...
    ~,~,m_dotlast(j+1),~,~,~,~] =...
    SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast(j),options);
end

m_dotlast2(1) = m_dotcycle_max;
q_reactor2(1) = q_reactor(1);
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor2(j+1),...
    ~,~,m_dotlast2(j+1),~,~,~,~] =...
    SpecifiedPower3(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast2(j),options);
end
 

% plot for UA vs Q_dot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
h = plot(q_reactor/1000,UA/1000);
col = get(h,'color');
hold on
plot(q_reactor2/1000,UA/1000,'color',col,'LineStyle','--')
scatter(q_reactor2(1)/1000,UA_min/1000,'k')
xlabel('Reactor Heat Output [kW]')
ylabel('UA [kW/K]')
grid on
ylim([0 21])
title('Cycle Power Output = 40 kW')

% plot for masses of reactor and recuperator%%%%%%%%%%%%%%%%%
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = 0.0131*UA; %convert to kW/K
% mass_radiator = 5.8684*A_panel;
mass_total = mass_reactor+mass_recuperator;

figure
plot(q_reactor/1000,mass_reactor)
hold on 
plot(q_reactor/1000,mass_recuperator)
h = plot(q_reactor/1000,mass_total,'k');
col = get(h,'color');
legend('Reactor','Recuperator','Combined','location','northwest')
xlabel('Reactor Heat Output [kW]')
ylabel('Mass [kg]')
title('Cycle Power Output = 40 kW')
set(gca, 'color', 'none')
grid on

% plot for masses of reactor and recuperator%%%%%%%%%%%%%%%%%
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = 0.0131*UA; %convert to kW/K
A_panel_plot = ones(1,length(UA))*A_panel;
mass_radiator = 5.8684*A_panel_plot;
mass_total = mass_reactor+mass_recuperator+mass_radiator;

figure
plot(q_reactor/1000,mass_reactor)
hold on 
plot(q_reactor/1000,mass_recuperator)
plot(q_reactor/1000,mass_radiator, 'r')
h = plot(q_reactor/1000,mass_total,'k');
col = get(h,'color');
% legend('Reactor','Recuperator','Reactor','Total','location','northwest')
text(q_reactor(1)/1000+3,mass_reactor(1),'Reactor')
text(q_reactor(1)/1000+3,mass_recuperator(1)+20,'Recuperator')
text(q_reactor(1)/1000+3,mass_radiator(1),'Radiator')
text(q_reactor(1)/1000+3,mass_total(1),'Total')
xlabel('Reactor Heat Output [kW]')
ylabel('Mass [kg]')
title('Cycle Power Output = 40 kW')
xlim([80 320])
grid on

% total mass plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
[min_mass,ind] = min(mass_total);
mass_pts = [mass_total(1),min_mass,mass_total(end)];
q_reactorpts = [q_reactor(1),q_reactor(ind),q_reactor(end)];
plot(q_reactor/1000,mass_total,'k')
hold on
a = scatter(q_reactorpts(1)/1000,mass_pts(1),'k');
b = scatter(q_reactorpts(2)/1000,mass_pts(2),'k');
c = scatter(q_reactorpts(3)/1000,mass_pts(3),'k');
% legend([a b c],{'A = Low Reactor Mass','B = Minimum Cycle Mass','C = Low Recuperator Mass'})
ht = text(140,1060,{'A  Large Recuperator','B  Large Reactor','C  Minimum Mass'},'EdgeColor','k','BackgroundColor','w');
% text(60,675,'A  Low Reactor Mass')
% text(60,657,'B  Minimum Cycle Mass')
% text(60,639,'C  Low Recuperator Mass')
xlabel('Reactor Heat Output [kW]')
ylabel('Combined Mass [kg]')
title('Cycle Power Output = 40 kW')
text(q_reactorpts(1)/1000+7,mass_pts(1)+5,'B')
text(q_reactorpts(2)/1000+7,mass_pts(2)-7,'C')
text(q_reactorpts(3)/1000+7,mass_pts(3)+5,'A')
% set(gca, 'color', 'none')
ylim([895 1090])
xlim([80 290])
grid on

% TS Diagrams %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% large Reactor
[~,cyc_efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotlast(1),p1,T4,PR_c,UA(1),...
    A_panel,T_amb,fluid,mode,1)
% title(['Reactor Heat Output = ', num2str(q_reactorpts(1)/1000),' [kW] (Point C)'])
title([])
set(gca, 'color', 'none')
grid on
react = mass_reactor(1)
recup = mass_recuperator(1)
tot = mass_total(1)

% minimum Mass
[~,cyc_efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotlast(ind+1),p1,T4,PR_c,UA(ind),...
    A_panel,T_amb,fluid,mode,1)
% title(['Reactor Heat Output = ', num2str(q_reactorpts(2)/1000),' [kW] (Point B)'])
title([])
set(gca, 'color', 'none')
grid on
react = mass_reactor(ind)
recup = mass_recuperator(ind)
tot = mass_total(ind)

% Large Recuperator 
[~,cyc_efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dotlast(end),p1,T4,PR_c,UA(end),...
    A_panel,T_amb,fluid,mode,1)
% title(['Reactor Heat Output = ', num2str(q_reactorpts(3)/1000),' [kW] (Point A)'])
title([])
set(gca, 'color', 'none')
grid on
react = mass_reactor(end)
recup = mass_recuperator(end)
tot = mass_total(end)

uamax =UA(end)
