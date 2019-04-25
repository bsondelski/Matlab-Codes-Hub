
figure(1)
plot(A_panel, T1(1,:))
xlabel('A_p_a_n_e_l')
ylabel('T_1 max')
grid on

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
plot(UA(:,1), T1(:,1))
xlabel('Recuperator Conductance [kW/K]')
ylabel('T_1')
grid on

figure(2)
plot(UA(:,1), mass_total(:,1))
xlabel('Recuperator Conductance [kW/K]')
ylabel('Mass [kg]')
grid on