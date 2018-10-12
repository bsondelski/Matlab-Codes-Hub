for i = 1:10
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.4969,25000,1100,2,3037.9,...
30,100,{'CO2','WATER',[0.51,0.49]},mode,0)
end

[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.6631,25000,1100,2,1.3367e4,...
36.2918,100,{'CO2','water',[0.9,0.1]},mode,0)





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


[minMass,UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot] = minRadRecMass( 50,40000,25000,1100,2,100,{'CO2','WATER',[0.51,0.49]},mode,1,2 )


[ UA_min,m_dotcycle_max ] = maxPowerMatch(40000,25000,1100,2,30,...
    100,{'CO2','WATER',[0.51,0.49]},mode);

[ UA_min,UA_max ] = maxPowerBoundFind( 40000,25000,1100,2,...
    30,100,{'CO2','WATER',[0.51,0.49]},mode )

[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.7,25000,1100,2,3.797414374794774e3,...
30,100,{'CO2','WATER',[0.51,0.49]},mode,0)

[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.996953317450395,25000,1100,2,1.317260206493552e+04+1e-10,...
30,100,'CO2',2,0);

A_panel = linspace(30,60,4);
for i = 1:length(A_panel)
[minMass(i),UA,UA_min,mass_reactor,mass_recuperator,mass_radiator,m_dot] = minRadRecMass( A_panel(i),40000,9000,1100,2,100,'CO2',2,1,2 );
end

UA = [3.245e3,4.0563e3,4.8676e3,5.6788e3,6.4901e3];
for i=1:length(UA)
[ mass_total(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = totalMass( UA(i),40000,25000,1100,2,60,...
    100,{'CO2','WATER',[0.99,0.01]},mode,1.2078,optimset('TolX',1e-5));
end

[err] = maxPowerError( 11155.55555,40000,25000,1100,...
            2,15,100,{'CO2','WATER',[0.51,0.49]},mode,optimset('TolX',1) )
        
        
%%%%%%%%%%%%%%%%%%%%%%% max power vs UA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p1 = 25000;
T4 = 1100;
PR_c = 2;
A_panel = 18;
T_amb = 100;
fluid = {'CO2','WATER',[0.51,0.49]};
desiredPower = 40000; % [W]

UA = linspace(100,100000);

for i = 1:length(UA)

[max_power(i),m_dot(i)] = findMaxPower2(p1,T4,PR_c,UA(i),A_panel,T_amb,fluid,mode,[]);
end
plot(UA/1000,max_power/1000)



[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
p5,T6,p6,A_panel,Vratio] = BraytonCycle(0.7922,25000,1100,2,11.406e3,...
54.0266,100,'CO2',2,0)







