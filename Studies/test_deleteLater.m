for i = 1:10
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.6447,25000,1100,2,8.5362e3,...
39.0505,100,'CO2',2,0)
end

[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.19,25000,1100,2,4.3736e3,...
25.7778,100,{'CO2','water',[]},mode,0)





T_H_in = 9.772215769894115e+02;
T_C_in = 5.525836736343623e+02;
p_H_in = 25000;
p_H_out = 25000;
p_C_in = 50000;
p_C_out = 50000;
m_dot_H = 0.663132141083406;
m_dot_C = 0.663132141083406;
UA = 5000;
fluid_C = {'CO2','water',[1,0.37]};
fluid_H = {'CO2','water',[1,0.37]};
ploton = 0;
[T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)
