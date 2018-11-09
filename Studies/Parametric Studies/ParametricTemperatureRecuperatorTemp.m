for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,~,p4,T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end

figure(1)
% hold on
scatter(T4,TotalMinMass,'filled','k')

ylabel('Mass of optimized cycle [kg]','fontsize',18)
xlabel('Turbine inlet temperature [K]','fontsize',18)

ax1 = gca;
ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','left',...
    'Color','none');
line(T5,TotalMinMass,'Parent',ax2,'Color','k')
xlim([T5(1),T5(end)])
xlabel('Recuperator inlet temperature [K]','fontsize',18)
box on
% get(gca,'OuterPosition')
% set(gca,'OuterPosition',[left bottom + 0.1 width height])