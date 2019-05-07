
figure(1)
xq = [A_panel(1):0.005:A_panel(end)];
s = spline(A_panel,T1(1,:),xq);
plot(xq, s,'k')
xlabel('Radiator Panel Area [m^2]')
ylabel('Temperature [K]')
grid on
hold on
xlim = get(gca,'xlim');
plot(xlim,[mode(1,end) mode(1,end)],'--k')
legend('Minimum Cycle Temperature','Dew Point Temperature')


figure(2)
plot(A_panel, UA(1,:)./1000,'k')
xlabel('Radiator Panel Area [m^2]')
ylabel('Minimum Recuperator Conductance [kW/K]')
grid on

for i = 1:length(A_panel)
[net_power(i),cyc_efficiency,~,~,~,~,~,q_reactor(i),...
    q_rad(i),T1(1,i),~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dot(1,i),p1,T4,PR_c,UA(1,i),...
    A_panel(i),T_amb,fluid,mode,0);
efficiency_cycle(i) = cyc_efficiency(1);
end

figure(3)
plot(A_panel, efficiency_cycle)
xlabel('A_p_a_n_e_l')
ylabel('cycle efficiency')
grid on

figure(4)
plot(A_panel, abs(q_rad)/1000)
xlabel('A_p_a_n_e_l')
ylabel('Rejected Heat')
grid on


figure(1)
xq = linspace(UA(1),UA(end),400);
s = spline(UA,T1,xq);
plot(xq./1000, s,'k')
xlabel('Recuperator Conductance [kW/K]')
ylabel('Temperature [K]')
grid on
hold on
xlim = get(gca,'xlim');
plot(xlim,[mode(1,end) mode(1,end)],'--k')
legend('Minimum Cycle Temperature','Dew Point Temperature')

figure(2)
plot(UA(:,1), mass_total(:,1))
xlabel('Recuperator Conductance [kW/K]')
ylabel('Mass [kg]')
grid on