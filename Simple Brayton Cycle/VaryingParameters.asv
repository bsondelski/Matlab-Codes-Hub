clear

p1 = 9000;
T4 = 1100;
PR_c = 2;


T_amb = 100;
fluid = 'CO2';
mode = 2;

desiredPower = 40000;

p1=8000:500:10000;

for i = 1:length(p1)
    [ mass(i) ] = minMass( p1(i),T4,PR_c,T_amb,fluid,mode,desiredPower );
end

plot(p1,mass)
xtitle('Low side pressure [kPa]')
ytitle('Mass [kg]')



clear p1
clear mass
p1=9000;
T4=900:50:1100;

for i = 1:length(T4)
    [ mass(i) ] = minMass( p1,T4(i),PR_c,T_amb,fluid,mode,desiredPower );
end

figure
plot(T4,mass)
xtitle('Hot side temperature [K]')
ytitle('Mass [kg]')



clear T4
clear mass
T4=1100;
PR_c=1.5:0.5:3.5;

for i = 1:length(PR_c)
    [ mass(i) ] = minMass( p1,T4,PR_c(i),T_amb,fluid,mode,desiredPower );
end

figure
plot(PR_c,mass)
xtitle('Pressure Ratio')
ytitle('Mass [kg]')