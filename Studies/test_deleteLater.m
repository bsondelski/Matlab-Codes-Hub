for i = 1:10
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.7922,9000,1100,2,1.1406e4,...
54.0266,100,'CO2',2,0)
end

