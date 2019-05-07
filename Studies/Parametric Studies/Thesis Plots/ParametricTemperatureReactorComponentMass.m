% plot to figure out why reactor mass increases with temperature - run with
% Inconel

for i=1:length(TotalMinMass)
rxtr = py.reactor_mass.reactor_mass('UO2', 'CO2', q_reactor(i), m_dot(i), [T3(i), T4(i)], [p3(i)*1000, p4(i)*1000])
mass(i) = rxtr.mass;
refl_mass(i) = rxtr.refl_mass;
fuel_mass(i) = rxtr.fuel_mass;
PV_mass(i) = rxtr.PV_mass;
clad_mass(i) = rxtr.clad_mass;
gen_Q(i) = rxtr.gen_Q;
end

figure(3)
% plot(T4,mass)

plot(T4,refl_mass)
hold on
plot(T4,fuel_mass)
plot(T4,PV_mass)
plot(T4,clad_mass)
delta = 10;
% text(T4(end)+delta,mass(end),'Total Reactor mass')
text(T4(end)+delta,clad_mass(end)+5,'Reflector mass','fontsize',12)
text(T4(end)+delta,fuel_mass(end),'Fuel mass','fontsize',12)
text(T4(end)+delta,PV_mass(end),'Pressure vessel mass','fontsize',12)
text(T4(end)+delta,refl_mass(end),'Cladding mass','fontsize',12)
xlim([850 1350])
ylim([0 100])
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
ylabel('Reactor Component Mass [kg]','fontsize',18)
grid on