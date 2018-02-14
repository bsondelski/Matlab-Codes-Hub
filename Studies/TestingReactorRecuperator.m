clear


% function inputs in future
p1 = 9000;
T4 = 1100;
PR_c = 2;
A_panel = 100; % 40:2:120;
T_amb = 100;
fluid = 'CO2';
mode = 2;
desiredPower = 40000; % [W]



% find minimum UA which gives desired power output
[ UA_min,m_dotcycle(1) ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);

% UA = [UA_min, UA_min+10000, UA_min+20000];
UA = UA_min:100:25000;

% preallocate space
net_power = zeros(1,length(UA));
cyc_efficiency = zeros(1,length(UA));
q_reactor = zeros(1,length(UA));
T3 = zeros(1,length(UA));
p3 = zeros(1,length(UA));
p4 = zeros(1,length(UA));

% first data point found from known values
[net_power(1),cyc_efficiency(1),D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(1),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(1),p3(1),~,p4(1),T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dotcycle(1),p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0);

% use specified power function to find data points for higher UA's
for i = 2:length(UA)
    UA(i)
[net_power(i),cyc_efficiency(i),D_T,D_c,Ma_T,Ma_c,q_reactor(i),...
    q_rad,T1,m_dotcycle(i),T3(i),p3(i),...
    ~,p4(i)] = SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(i),A_panel,...
    T_amb,fluid,mode,m_dotcycle(i-1));
end

% mass correlations
mass_reactor = 0.002*q_reactor+100;
mass_recuperator = 0.0131*UA; %convert to kW/K
mass_radiator = 5.8684*A_panel;
mass_total = mass_reactor+mass_recuperator+mass_radiator;

% quadratic approximitation to minimize mass
























figure
plot(UA/1000,net_power/1000)
xlabel('UA [kW/K]')
ylabel('Net power output [W]')
figure
plot(UA/1000,cyc_efficiency)
xlabel('UA [kW/K]')
ylabel('Cycle efficiency')
figure
plot(UA/1000,q_reactor/1000)
xlabel('UA [kW/K]')
ylabel('Reactor heat output [kW]')
grid on
figure
plot(UA/1000,m_dotcycle)
xlabel('UA [kW/K]')
ylabel('Mass flow rate [kg/s]')
figure
plot(UA/1000,T3)
xlabel('UA [kW/K]')
ylabel('Input reactor temperature')

recup_mass = 0.0131*UA; %convert to kW/K
plot(UA/1000,recup_mass)
xlabel('UA [kW/K]')
ylabel('Mass [kg]')

T=table(UA'/1000,net_power'/1000,cyc_efficiency',q_reactor'/1000,m_dotcycle',T3');
