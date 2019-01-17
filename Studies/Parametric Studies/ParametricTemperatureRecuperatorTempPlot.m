% plot temperature mass dependence along with recuperator inlet temps


for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)
%%%%%%%%%%%%%%%%%%%%  Section 1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load SS data and run with this block - comment out section 2
figure
set(gcf, 'units','normalized','outerposition',[0 0 0.5 0.8]);
plot(T4(1:6),TotalMinMass(1:6),'--k','linewidth',1.5)
hold on
plot(T4(6:end),TotalMinMass(6:end),':k','linewidth',1.5)
set(gca,'box','off')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%  Section 2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load Inconel data and run with this block - comment out section 1
plot(T4,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
legend({'Stainless Steel Near Term','Stainless Steel Far Term','Inconel'},'fontsize',12,'location','north')


ax1 = gca;
ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
line(T5,TotalMinMass,'Parent',ax2,'Color','k')
set(gca,'YTickLabel',[])
xlim([T5(1),T5(end)])
ylim([600 1050])
xlabel('Recuperator Inlet Temperature [K]','fontsize',18)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
text(T4(end)+delta,refl_mass(end)-3,'Reflector mass','fontsize',12)
text(T4(end)+delta,fuel_mass(end),'Fuel mass','fontsize',12)
text(T4(end)+delta,PV_mass(end),'Pressure vessel mass','fontsize',12)
text(T4(end)+delta,clad_mass(end)+5,'Cladding mass','fontsize',12)
xlim([850 1265])
ylim([0 150])
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
ylabel('Reactor Component Mass [kg]','fontsize',18)
grid on