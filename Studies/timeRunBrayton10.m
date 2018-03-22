for i = 1:10
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,p5,T6,p6] = BraytonCycle(0.75,9000,1100,2,10000,100,100,'CO2',3,0) 
end
