p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=100;
T_amb=200;
fluid='CO2';
mode=2;
desiredPower = 40000;
NucFuel = 'UO2';

[ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);
% UA_min = UA_min + 400;
UA_min = UA_min;
UA=UA_min:50:UA_min+8000; % was 2022.3
m_dotlast(1) = m_dotcycle_max;

[net_power,~,~,~,~,~,~,q_reactor(1),...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,T5(1),...
    ~,~,~,~,~] = BraytonCycle(m_dotcycle_max,p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0)

options = [];
for j=1:(length(UA)-1)
    UA(j)
    [~,~,~,~,~,~,q_reactor(j+1),...
        ~,~,m_dotlast(j+1),T3(j+1),p3,T4out(j+1),p4,T5(j+1)] =...
        SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast(j),options);
    mass_reactor(j) = ReactorMass(q_reactor(j+1),m_dotlast(j+1),p3,p4,T3(j+1),T4out(j+1),fluid,NucFuel);
%     mass_recuperator(j) = 0.008565*UA(j); %convert to kW/K
    mass_recuperator(j) = RecuperatorMass( T5(j),'SS',UA(j),fluid );
end

mass_comb = mass_reactor + mass_recuperator;

figure(1)
plot(mass_recuperator,mass_reactor,'k')
xlabel('Recuperator Mass [kg]','fontsize',18)
ylabel('Reactor Mass [kg]','fontsize',18)
grid on
figure(2)
plot(UA/1000,q_reactor/1000,'k')
xlabel('Recuperator Conductance [kW/K]','fontsize',18)
ylabel('Reactor Heat Input [kW]','fontsize',18)
grid on
xlim([ 1 11])
figure(3)
plot(UA(2:end)/1000,mass_comb,'k')
xlabel('Recuperator Conductance [kW/K]','fontsize',18)
ylabel('Combined Mass [kg]','fontsize',18)
xlim([ 1 11])
grid on
% figure
% plot(UA(2:end)/1000,mass_reactor)

% checks for Alex
% figure
% plot(q_reactor(2:end)/1000,mass_reactor)
% xlabel('Reactor Heat Input [kW]')
% ylabel('Reactor Mass [kg]')
% figure
% plot(q_reactor(2:end)/1000,T3(2:end),q_reactor(2:end)/1000,T4out(2:end))
% ylabel('Temperature [K]')
% legend('T_i_n','T_o_u_t')
% xlabel('Reactor Heat Input [kW]')
% figure
% plot(q_reactor(2:end)/1000,m_dotlast(2:end))
% xlabel('Reactor Heat Input [kW]')
% ylabel('Mass Flow Rate [kg/s]')
