




Tamb = 0:10:300;
parfor i = 1:length(Tamb)
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,900,2,Tamb(i),'CO2',2,'UO2','SS')
end

for j = 1:length(Tamb)
    [net_power(j),cyc_efficiency(j,1:2),D_T(j),D_c(j),Ma_T(j),Ma_c(j),Anozzle(j),q_reactor(j),...
        q_rad(j),T1(j),Power_T(j),Power_c(j),HEXeffect(j),energy(j),p1(j),T2(j),p2(j),T3(j),p3(j),T4(j),p4(j),T5(j),...
        p5(j),T6(j),p6(j),~,Vratio(j)] = BraytonCycle(0.7399,9000,1100,2,9.1876e3,...
        40.7044,Tamb(j),'CO2',2,0);

end

figure(1)
plot(Tamb,net_power/1000)
xlabel('Sink Temperature [K]')
ylabel('Net Power Output [kW]')

figure(2)
plot(Tamb,q_rad)
xlabel('Sink Temperature [K]')
ylabel('Radiated Heat [kW]')

figure(3)
plot(Tamb,T1)
xlabel('Sink Temperature [K]')
ylabel('Temperature at Radiator Outlet [K]')

figure(4)
plot(Tamb,T6)
xlabel('Sink Temperature [K]')
ylabel('Temperature at Radiator Inlet [K]')








Tamb = 0:10:300;

for i = 1:length(Tamb)
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),...
    mass_recuperator(i),mass_radiator(i) ]...
    = minimizeTotalMass( 40000,9000,1100,2,Tamb(i),'CO2',2 );
end

figure(4)
plot(Tamb,TotalMinMass)
title('Optimized Cycles')
xlabel('Sink Temperature [K]')
ylabel('Total Cycle Mass [kg]')

figure(5)
plot(Tamb,mass_reactor,Tamb,mass_recuperator,Tamb,mass_radiator)
title('Optimized Cycles')
xlabel('Sink Temperature [K]')
ylabel('Mass [kg]')
legend('Reactor','Recuperator','Radiator')

figure(7)
plot(Tamb,A_panel)
xlabel('Sink Temperature [K]')
ylabel('Radiator size [m^2]')